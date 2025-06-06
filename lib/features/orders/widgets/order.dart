import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Order extends StatelessWidget {
  final String orderId;

  const Order({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('orders').doc(orderId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final screenshot = data['screenshot'];
        final amount = data['amount']?.toDouble() ?? 0;
        final method = data['method'] ?? '—';
        final createdAt = (data['createdAt'] as Timestamp).toDate();
        final renterName = data['renterName'] ?? 'Cliente';
        final status = data['status'];
        final createdAtFormatted = DateFormat('dd/MM/yyyy – HH:mm').format(createdAt);

        return Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('← Regresar', style: TextStyle(color: Colors.white)),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: status == 'confirmed' ? Colors.green.withOpacity(0.2) : Colors.amber.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status == 'confirmed' ? 'Confirmada' : 'Pendiente',
                        style: TextStyle(color: status == 'confirmed' ? Colors.green : Colors.amber, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                const Text('Verificación de Pago', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('Revisa los detalles del pago y confirma si fue recibido correctamente', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 24),

                // Captura
                Text('Captura de Pago', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                screenshot != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(screenshot),
                )
                    : const Text('No hay imagen', style: TextStyle(color: Colors.grey)),

                const SizedBox(height: 24),

                // Detalles de pago
                Text('Detalles del Rental', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                _infoRow('Método de pago:', method),
                _infoRow('Monto:', '\$${amount.toStringAsFixed(2)}'),
                _infoRow('Fecha:', createdAtFormatted),
                const SizedBox(height: 24),

                // Cliente
                Text('Información del Cliente', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 12),
                _infoRow('Nombre:', renterName),

                const SizedBox(height: 32),

                // Acciones
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection('orders').doc(orderId).update({'status': 'confirmed'});
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pago confirmado'), backgroundColor: Colors.green),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text('✓ Confirmar Pago Recibido'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection('orders').doc(orderId).update({'status': 'canceled'});
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pago marcado como no recibido'), backgroundColor: Colors.red),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('✗ Marcar como No Recibido'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}