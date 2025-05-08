import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<UserCredential> registerWithEmail({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = result.user!;
    final now = DateTime.now();

    UserModel userModel = UserModel(
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
}
