import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../models/address_model.dart';
import '../models/identity_verification.dart';
import '../models/user_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Registro con email/password y creación de usuario en Firestore
  Future<UserCredential> registerWithEmail({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user!;
    final now = DateTime.now();

    // ✅ Crear modelo completo
    final userModel = UserModel(
      userId: user.uid,
      fullName: fullName,
      username: username,
      email: email,
      phone: '',
      profileImageUrl: '',
      role: 'user',
      createdAt: now,
      lastLoginAt: now,
      rating: 0,
      totalRentsMade: 0,
      totalRentsReceived: 0,
      blocked: false,
      reports: 0,
      verified: false,
      address: AddressModel(
        street: '',
        city: '',
        state: '',
        country: '',
        zipCode: '',
      ),
      identityVerification: IdentityVerification(
        frontImageUrl: '',
        backImageUrl: '',
        selfieWithIdUrl: '',
        residenceProofUrl: '',
        status: 'not_submitted',
        submittedAt: null,
        verifiedAt: null,
        verifiedBy: null,
      ),
      preferences: UserPreferences(
        receiveNotifications: true,
        preferredLanguage: 'es',
        theme: 'system',
        categoriesOfInterest: [],
      ),
    );

    // ✅ Guardar en Firestore
    await _db.collection('users').doc(user.uid).set(userModel.toMap());

    return result;
  }
  Stream<UserModel> userStream(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) => UserModel.fromMap(doc.data()!));
  }


  /// Obtener usuario actual
  User? get currentUser => _auth.currentUser;
}
