import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/rental_model.dart';

class RentalService {
  final _rentalsRef = FirebaseFirestore.instance.collection('rentals');

  Future<void> createRental(RentalModel rental) async {
    final docRef = _rentalsRef.doc();
    final newRental = rental.copyWith(rentalId: docRef.id);
    await docRef.set(newRental.toJson());
  }
}
