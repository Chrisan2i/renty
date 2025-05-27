import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/rental_request_model.dart';

class RentalRequestService {
  final CollectionReference _rentalRequestsRef =
  FirebaseFirestore.instance.collection('rentalRequests');

  /// ✅ Crea una nueva solicitud de alquiler
  Future<void> createRentalRequest(RentalRequestModel request) async {
    await _rentalRequestsRef.add(request.toMap());
  }

  /// ✅ Obtiene todas las solicitudes para un propietario
  Future<List<RentalRequestModel>> getRequestsByOwner(String ownerId) async {
    final querySnapshot = await _rentalRequestsRef
        .where('ownerId', isEqualTo: ownerId)
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => RentalRequestModel.fromMap(
      doc.data() as Map<String, dynamic>,
      doc.id,
    ))
        .toList();
  }

  /// ✅ Obtiene todas las solicitudes hechas por un arrendatario
  Future<List<RentalRequestModel>> getRequestsByRenter(String renterId) async {
    final querySnapshot = await _rentalRequestsRef
        .where('renterId', isEqualTo: renterId)
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => RentalRequestModel.fromMap(
      doc.data() as Map<String, dynamic>,
      doc.id,
    ))
        .toList();
  }

  /// ✅ Obtener una sola solicitud por ID
  Future<RentalRequestModel?> getRequestById(String requestId) async {
    final doc = await _rentalRequestsRef.doc(requestId).get();
    if (!doc.exists) return null;

    return RentalRequestModel.fromMap(
      doc.data() as Map<String, dynamic>,
      doc.id,
    );
  }

  /// ✅ Actualizar el estado de una solicitud (approve, reject)
  Future<void> updateRequestStatus(String requestId, String status,
      {Timestamp? respondedAt}) async {
    await _rentalRequestsRef.doc(requestId).update({
      'status': status,
      if (respondedAt != null) 'respondedAt': respondedAt,
    });
  }
}
