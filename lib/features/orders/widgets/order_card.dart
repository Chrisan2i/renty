import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/orders/views/order_page.dart';

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String orderId;

  const OrderCard({super.key, required this.data, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final productName = data['productName'] ?? 'Producto';
    final renterName = data['renterName'] ?? 'Usuario';
    final amount = data['amount']?.toDouble() ?? 0;
    final duration = data['duration'] ?? '—';
    final Timestamp? startTimestamp = data['startDate'];
    final Timestamp? endTimestamp = data['endDate'];

    final start = startTimestamp != null
        ? (startTimestamp.toDate().toString().split(' ')[0])
        : '—';

    final end = endTimestamp != null
        ? (endTimestamp.toDate().toString().split(' ')[0])
        : '—';

    final method = data['paymentMethod'] ?? '—';
    final status = data['status'] ?? 'pending';

    Color badgeColor;
    String badgeText;
    if (status == 'confirmed') {
      badgeColor = Colors.green;
      badgeText = 'Confirmada';
    } else {
      badgeColor = Colors.amber;
      badgeText = 'Pendiente Confirmación';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(productName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(badgeText, style: TextStyle(color: badgeColor, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Orden: $orderId', style: const TextStyle(color: Colors.blueAccent)),
          Text('Rentado por: $renterName', style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoBox('\$${amount.toStringAsFixed(2)}', 'Monto'),
              _infoBox('$duration días', 'Duración'),
              _infoBox(start, 'Fecha Inicio'),
              _infoBox(end, 'Fecha Fin'),
            ],
          ),
          const SizedBox(height: 12),
          Text('Método de pago: $method', style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 16),

          Row(
            children: [
              if (status == 'pending')
                ElevatedButton(
                  onPressed: () {
                    // Acción: Confirmar pago
                  },
                  child: const Text('Confirmar Pago'),
                ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderPage(orderId: orderId),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
                child: const Text('Ver Detalles'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _infoBox(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
      ],
    );
  }
}