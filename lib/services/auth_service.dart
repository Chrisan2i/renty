import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Registro con email/password y crea el documento en Firestore
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
      address: {
        'street': '',
        'city': '',
        'state': '',
        'zip': '',
        'country': '',
        'latitude': null,
        'longitude': null,
      },
      identityVerification: {
        'type': '',
        'number': '',
        'frontImageUrl': '',
        'backImageUrl': '',
        'selfieWithIdUrl': '',
        'faceScanData': null,
        'verified': false,
        'verifiedBy': '',
        'verifiedAt': null,
      },
      wallet: {
        'balance': 0.0,
        'currency': 'USD',
        'lastUpdated': now.toIso8601String(),
      },
      preferences: {
        'language': 'es',
        'receiveNotifications': true,
        'darkMode': false,
      },
      paymentMethods: [],
      rating: 0,
      totalRentsMade: 0,
      totalRentsReceived: 0,
      blocked: false,
      banReason: null,
      reports: 0,
      notesByAdmin: '',
    );

    await _db.collection('users').doc(user.uid).set(userModel.toJson());
    return result;
  }

  /// Actualiza la fecha de último login
  Future<void> updateLastLogin(String uid) async {
    await _db
        .collection('users')
        .doc(uid)
        .update({'lastLoginAt': DateTime.now().toIso8601String()});
  }

  /// Obtiene el UserModel una sola vez
  Future<UserModel> getUserModelOnce(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return UserModel.fromDocument(doc);
  }

  /// Stream para escuchar cambios en el documento de usuario
  Stream<UserModel> userStream(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) => UserModel.fromDocument(doc));
  }
}
