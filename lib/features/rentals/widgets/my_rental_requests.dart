import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../features/payment/views/payment_page.dart';

class MyRentalRequests extends StatefulWidget {
  const MyRentalRequests({Key? key}) : super(key: key);

  @override
  State<MyRentalRequests> createState() => _MyRentalRequestsState();
}

class _MyRentalRequestsState extends State<MyRentalRequests> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _statuses = ['All', 'Pending', 'Accepted', 'Rejected'];
  final Map<String, String> statusMap = {
    'Pending': 'pending',
    'Accepted': 'accepted',
    'Rejected': 'rejected',
  };

  bool showReceived = true;

  @override
  void initState() {
    _tabController = TabController(length: _statuses.length, vsync: this);
    super.initState();
  }

  Stream<QuerySnapshot>? _rentalRequestsStream(String status) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;

    final baseQuery = FirebaseFirestore.instance
        .collection('rentalRequests')
        .where(showReceived ? 'ownerId' : 'renterId', isEqualTo: uid);

    if (status == 'All') {
      return baseQuery.snapshots();
    } else {
      final statusValue = statusMap[status];
      return baseQuery.where('status', isEqualTo: statusValue).snapshots();
    }
  }

  Future<Map<String, String>> _loadCardData(Map<String, dynamic> data) async {
    String productTitle = 'Producto no encontrado';
    String ownerUsername = 'Usuario no encontrado';

    try {
      final productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(data['productId'])
          .get();

      if (productDoc.exists) {
        productTitle = productDoc.data()?['title'] ?? productTitle;
      }

      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: data['ownerId'])
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        ownerUsername = userQuery.docs.first.data()['username'] ?? ownerUsername;
      }
    } catch (e) {
      debugPrint('Error al cargar datos para la tarjeta: $e');
    }

    return {
      'productTitle': productTitle,
      'ownerUsername': ownerUsername,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              Text(
                'Gestiona las solicitudes de renta (enviadas o recibidas)',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => setState(() => showReceived = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: showReceived ? Colors.blue : Colors.grey[800],
                  foregroundColor: Colors.white,
                ),
                child: const Text("Recibidas"),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () => setState(() => showReceived = false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: !showReceived ? Colors.blue : Colors.grey[800],
                  foregroundColor: Colors.white,
                ),
                child: const Text("Enviadas"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: _statuses.map((s) => Tab(text: s)).toList(),
            isScrollable: true,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: TabBarView(
            controller: _tabController,
            children: _statuses.map((status) {
              final stream = _rentalRequestsStream(status);
              if (stream == null) {
                return const Center(
                  child: Text('User not logged in', style: TextStyle(color: Colors.white)),
                );
              }

              return StreamBuilder<QuerySnapshot>(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final docs = snapshot.data?.docs ?? [];

                  if (docs.isEmpty) {
                    return const Center(
                      child: Text('No requests found', style: TextStyle(color: Colors.white)),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;
                      final requestId = doc.id;

                      return FutureBuilder<Map<String, String>>(
                        future: _loadCardData(data),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 24),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E1E1E),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade800),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(backgroundColor: Colors.grey),
                                      SizedBox(width: 8),
                                      Text('Cargando...', style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Text('Producto...', style: TextStyle(color: Colors.grey)),
                                  SizedBox(height: 8),
                                  Text('Fechas...', style: TextStyle(color: Colors.grey)),
                                  SizedBox(height: 4),
                                  Text('Total: ---', style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            );
                          }

                          final productTitle = snapshot.data!['productTitle']!;
                          final ownerUsername = snapshot.data!['ownerUsername']!;

                          return _RentalRequestCard(
                            data: data,
                            requestId: requestId,
                            isReceived: showReceived,
                            productTitle: productTitle,
                            ownerUsername: ownerUsername,
                          );
                        },
                      );
                    },
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _RentalRequestCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String requestId;
  final bool isReceived;
  final String productTitle;
  final String ownerUsername;

  const _RentalRequestCard({
    required this.data,
    required this.requestId,
    required this.isReceived,
    required this.productTitle,
    required this.ownerUsername,
  });

  String _cleanStatus(String rawStatus) {
    return rawStatus.capitalize();
  }

  Future<void> _updateStatus(BuildContext context, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('rentalRequests')
          .doc(requestId)
          .update({'status': newStatus});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Solicitud $newStatus'.capitalize())),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error actualizando solicitud: $e')),
      );
    }
  }

  void _proceedToPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(requestId: requestId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusRaw = data['status'] ?? 'pending';
    final status = _cleanStatus(statusRaw);
    final startDate = data['startDate'] ?? '';
    final endDate = data['endDate'] ?? '';
    final total = data['total']?.toString() ?? '\$0';
    final message = data['message'] ?? '';
    final duration = data['duration']?.toString() ?? '';

    Color statusColor;
    switch (status) {
      case 'Accepted':
        statusColor = Colors.green;
        break;
      case 'Rejected':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.amber;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Text(ownerUsername.substring(0, 2).toUpperCase()),
                    backgroundColor: Colors.blueGrey,
                  ),
                  const SizedBox(width: 8),
                  Text(ownerUsername, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(productTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Start: $startDate', style: const TextStyle(color: Colors.grey)),
              const SizedBox(width: 16),
              Text('End: $endDate', style: const TextStyle(color: Colors.grey)),
              const SizedBox(width: 16),
              Text('Duration: $duration', style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          Text('Total: $total', style: const TextStyle(color: Colors.blueAccent)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2B2B2B),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(message, style: const TextStyle(color: Colors.white70)),
          ),
          const SizedBox(height: 12),
          if (statusRaw == 'pending' && isReceived) ...[
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _updateStatus(context, 'accepted'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text('Aceptar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _updateStatus(context, 'rejected'),
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Rechazar'),
                  ),
                ),
              ],
            ),
          ] else if (!isReceived && statusRaw == 'accepted') ...[
            ElevatedButton(
              onPressed: () => _proceedToPayment(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Proceder con el pago'),
            ),
          ] else if (statusRaw == 'accepted') ...[
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(foregroundColor: Colors.tealAccent),
              child: const Text('Contactar al solicitante'),
            ),
          ],
        ],
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}
