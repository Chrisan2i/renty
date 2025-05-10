import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renty/features/rentals/models/rental_model.dart';
import 'package:renty/features/chat/services/chat_service.dart';

class RentalRequestsPage extends StatelessWidget {
  const RentalRequestsPage({super.key});

  Stream<List<RentalModel>> getOwnerRentals() {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('rentals')
        .where('ownerId', isEqualTo: currentUserId)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => RentalModel.fromJson(doc.data())).toList());
  }

  Future<void> updateStatus(String rentalId, String status, RentalModel rental) async {
    await FirebaseFirestore.instance
        .collection('rentals')
        .doc(rentalId)
        .update({'status': status});

    if (status == 'confirmed') {
      await ChatService().createChatIfNotExists(
        rentalId: rental.rentalId,
        productId: rental.itemId,
        ownerId: rental.ownerId,
        renterId: rental.renterId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitudes pendientes')),
      body: StreamBuilder<List<RentalModel>>(
        stream: getOwnerRentals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final rentals = snapshot.data ?? [];

          if (rentals.isEmpty) {
            return const Center(child: Text('No hay solicitudes pendientes.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rentals.length,
            itemBuilder: (context, index) {
              final rental = rentals[index];
              final days = rental.endDate.difference(rental.startDate).inDays + 1;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Producto: ${rental.itemId}'),
                      Text('Cliente: ${rental.renterId}'),
                      Text('Desde: ${rental.startDate.toLocal().toString().split(" ")[0]}'),
                      Text('Hasta: ${rental.endDate.toLocal().toString().split(" ")[0]}'),
                      Text('Total: \$${rental.totalPrice.toStringAsFixed(2)} ($days días)'),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.check),
                            onPressed: () => updateStatus(rental.rentalId, 'confirmed', rental),
                            label: const Text('Confirmar'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.cancel),
                            onPressed: () => updateStatus(rental.rentalId, 'rejected', rental),
                            label: const Text('Rechazar'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

