import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../features/orders/widgets/order_card.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with TickerProviderStateMixin {
  late TabController _tabController;
  bool showAsOwner = false; // false = renter, true = owner

  final List<String> _filters = ['Todas', 'Pendientes', 'Completadas', 'Canceladas'];

  @override
  void initState() {
    _tabController = TabController(length: _filters.length, vsync: this);
    super.initState();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _orderStream(String filter, String userId) {
    final baseQuery = FirebaseFirestore.instance
        .collection('orders')
        .where(showAsOwner ? 'ownerId' : 'renterId', isEqualTo: userId);

    switch (filter) {
      case 'Pendientes':
        return baseQuery.where('status', isEqualTo: 'pending').snapshots();
      case 'Completadas':
        return baseQuery.where('status', isEqualTo: 'confirmed').snapshots();
      case 'Canceladas':
        return baseQuery.where('status', isEqualTo: 'canceled').snapshots();
      default:
        return baseQuery.snapshots(); // Todas
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 4),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Text(
              'Gestiona las órdenes de tus artículos rentados y confirma los pagos recibidos',
              style: TextStyle(color: Colors.grey),
            )
          ),
        ),
        const SizedBox(height: 16),

        // Toggle Arrendador / Arrendatario
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              TextButton(
                onPressed: () => setState(() => showAsOwner = false),
                style: TextButton.styleFrom(
                  backgroundColor: !showAsOwner ? Colors.blue : Colors.grey[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Arrendatario'),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () => setState(() => showAsOwner = true),
                style: TextButton.styleFrom(
                  backgroundColor: showAsOwner ? Colors.blue : Colors.grey[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Arrendador'),
              ),
            ],
          ),
        ),

        // Filtros por estado
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: _filters.map((f) => Tab(text: f)).toList(),
          isScrollable: true,
        ),

        const SizedBox(height: 12),

        // Contenido
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _filters.map((filter) {
              return StreamBuilder(
                stream: _orderStream(filter, currentUserId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty) {
                    return const Center(
                      child: Text('No hay órdenes aún', style: TextStyle(color: Colors.white)),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: docs.length,
                    itemBuilder: (_, index) {
                      final data = docs[index].data();
                      final id = docs[index].id;
                      return OrderCard(data: data, orderId: id);
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