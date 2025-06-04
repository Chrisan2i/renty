import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Payment extends StatefulWidget {
  final String requestId;

  const Payment({Key? key, required this.requestId}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Map<String, dynamic>? rentalData;
  String? productTitle;
  String? ownerName;
  String? imageUrl;
  bool isLoading = true;
  Map<String, dynamic>? paymentMethods;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchRentalData();
  }

  Future<void> fetchRentalData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('rentalRequests')
          .doc(widget.requestId)
          .get();

      if (!doc.exists) return;

      final data = doc.data()!;
      final productId = data['productId'];
      final ownerId = data['ownerId'];

      final productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();
      final product = productDoc.data();
      final title = product?['title'] ?? 'Producto sin título';
      final images = product?['images'] ?? [];
      final img = images.isNotEmpty ? images[0] : null;

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(ownerId)
          .get();
      final user = userDoc.data();
      final username = user?['username'] ?? 'Usuario sin nombre';
      print('Métodos desde Firestore: ${user?['paymentMethods']}');
      setState(() {
        rentalData = data;
        productTitle = title;
        ownerName = username;
        imageUrl = img;
        paymentMethods = user?['paymentMethods'] ?? {};
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error al cargar datos: $e');
    }
  }

  List<String> getValidPaymentKeys() {
    if (paymentMethods == null) return [];

    final keys = <String>[];

    bool hasValidFields(Map? map, List<String> requiredFields) {
      if (map == null) return false;
      for (var field in requiredFields) {
        final value = map[field];
        if (value == null || value.toString().trim().isEmpty) {
          return false;
        }
      }
      return true;
    }

    if (paymentMethods!.containsKey('binance') &&
        hasValidFields(paymentMethods!['binance'], ['binanceUser'])) {
      keys.add('binance');
    }

    if (paymentMethods!.containsKey('transferencia') &&
        hasValidFields(paymentMethods!['transferencia'], ['bank', 'accountNumber', 'titular'])) {
      keys.add('transferencia');
    }

    if (paymentMethods!.containsKey('pagoMovil') &&
        hasValidFields(paymentMethods!['pagoMovil'], ['bank', 'phoneNumber', 'idOrRif', 'titular'])) {
      keys.add('pagoMovil');
    }

    return keys;
  }

  String getDisplayName(String key) {
    switch (key) {
      case 'binance':
        return 'USDT';
      case 'transferencia':
        return 'Transferencia';
      case 'pagoMovil':
        return 'Pago Móvil';
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || rentalData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final Timestamp? startTs = rentalData!['startDate'];
    final Timestamp? endTs = rentalData!['endDate'];
    final startDate = startTs != null ? DateFormat('yyyy-MM-dd').format(startTs.toDate()) : '';
    final endDate = endTs != null ? DateFormat('yyyy-MM-dd').format(endTs.toDate()) : '';
    final dailyRate = rentalData!['dailyRate'] ?? 0;
    final securityDeposit = 100;
    final duration = rentalData!['duration'] ?? 0;
    final subtotal = dailyRate * duration;
    final tax = subtotal * 0.08;
    final total = subtotal + tax;

    final validKeys = getValidPaymentKeys();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Complete Your Rental',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 120,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: imageUrl != null
                    ? Image.network(imageUrl!, fit: BoxFit.cover)
                    : const Center(child: Text('Sin imagen', style: TextStyle(color: Colors.white))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productTitle ?? 'Product',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '@${ownerName ?? 'Usuario'}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    const Text('⭐ 4.8 (42 reviews)', style: TextStyle(color: Colors.blueAccent)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: startDate,
                            decoration: const InputDecoration(
                              labelText: 'Rental Start Date',
                              filled: true,
                              fillColor: Colors.black12,
                            ),
                            readOnly: true,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            initialValue: endDate,
                            decoration: const InputDecoration(
                              labelText: 'Rental End Date',
                              filled: true,
                              fillColor: Colors.black12,
                            ),
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Daily Rate        \$${dailyRate.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
                    Text('Security Deposit \$${securityDeposit.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
                    Text('Subtotal         \$${subtotal.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
                    Text('Tax (8%)         \$${tax.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
                    const Divider(color: Colors.white),
                    Text('Total            \$${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 32),

          const Text('Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),

          if (validKeys.isEmpty)
            const Text('Este usuario no tiene métodos de pago disponibles.', style: TextStyle(color: Colors.red))
          else ...[
            ToggleButtons(
              isSelected: List.generate(validKeys.length, (index) => index == selectedIndex),
              children: validKeys.map((key) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(getDisplayName(key)),
              )).toList(),
              onPressed: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              color: Colors.white,
              selectedColor: Colors.blueAccent,
              fillColor: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 16),
            Builder(builder: (context) {
              final key = validKeys[selectedIndex];
              final method = paymentMethods?[key];

              if (method is! Map) return const SizedBox();

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: method.entries.map<Widget>((entry) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '${entry.key}: ${entry.value}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
          ],

          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  // Aquí iría la lógica de confirmación y pago
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text('Confirm Rental'),
              ),
            ],
          )
        ],
      ),
    );
  }
}