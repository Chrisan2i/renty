import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/rental_request_model.dart';

class RentalRequestService {
  final CollectionReference _rentalRequestsRef =
  FirebaseFirestore.instance.collection('rentalRequests');

  /// Crea una nueva solicitud de alquiler
  Future<void> createRentalRequest(RentalRequestModel request) async {
    await _rentalRequestsRef.add(request.toMap());
  }

  /// Obtiene todas las solicitudes para un propietario
  Future<List<RentalRequestModel>> getRequestsByOwner(String ownerId) async {
    final querySnapshot = await _rentalRequestsRef
        .where('ownerId', isEqualTo: ownerId)
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => RentalRequestModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  /// Obtiene todas las solicitudes hechas por un arrendatario
  Future<List<RentalRequestModel>> getRequestsByRenter(String renterId) async {
    final querySnapshot = await _rentalRequestsRef
        .where('renterId', isEqualTo: renterId)
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => RentalRequestModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  /// Actualiza el estado de la solicitud (accepted, rejected, etc.)
  Future<void> updateRequestStatus(String requestId, String newStatus) async {
    await _rentalRequestsRef.doc(requestId).update({
      'status': newStatus,
      'respondedAt': Timestamp.now(),
    });
  }

  /// Elimina una solicitud
  Future<void> deleteRequest(String requestId) async {
    await _rentalRequestsRef.doc(requestId).delete();
  }
}
