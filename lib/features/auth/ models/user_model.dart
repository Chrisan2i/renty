import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String fullName;
  final String username;
  final String email;
  final String phone;
  final String profileImageUrl;
  final String role;
  final DateTime createdAt;
  final DateTime lastLoginAt;
  final Map<String, dynamic> address;
  final Map<String, dynamic> identityVerification;
  final Map<String, dynamic> wallet;
  final Map<String, dynamic> preferences;
  final List<dynamic> paymentMethods;
  final int rating;
  final int totalRentsMade;
  final int totalRentsReceived;
  final bool blocked;
  final String? banReason;
  final int reports;
  final String notesByAdmin;

  UserModel({
    required this.userId,
    required this.fullName,
    required this.username,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
    required this.role,
    required this.createdAt,
    required this.lastLoginAt,
    required this.address,
    required this.identityVerification,
    required this.wallet,
    required this.preferences,
    required this.paymentMethods,
    required this.rating,
    required this.totalRentsMade,
    required this.totalRentsReceived,
    required this.blocked,
    required this.banReason,
    required this.reports,
    required this.notesByAdmin,
  });

  /// Mapea desde Firestore
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final json = doc.data() as Map<String, dynamic>;
    return UserModel.fromJson(json);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json['userId'],
    fullName: json['fullName'],
    username: json['username'],
    email: json['email'],
    phone: json['phone'],
    profileImageUrl: json['profileImageUrl'],
    role: json['role'],
    createdAt: DateTime.parse(json['createdAt']),
    lastLoginAt: DateTime.parse(json['lastLoginAt']),
    address: Map<String, dynamic>.from(json['address']),
    identityVerification:
    Map<String, dynamic>.from(json['identityVerification']),
    wallet: Map<String, dynamic>.from(json['wallet']),
    preferences: Map<String, dynamic>.from(json['preferences']),
    paymentMethods: List<dynamic>.from(json['paymentMethods']),
    rating: json['rating'],
    totalRentsMade: json['totalRentsMade'],
    totalRentsReceived: json['totalRentsReceived'],
    blocked: json['blocked'],
    banReason: json['banReason'],
    reports: json['reports'],
    notesByAdmin: json['notesByAdmin'],
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'fullName': fullName,
    'username': username,
    'email': email,
    'phone': phone,
    'profileImageUrl': profileImageUrl,
    'role': role,
    'createdAt': createdAt.toIso8601String(),
    'lastLoginAt': lastLoginAt.toIso8601String(),
    'address': address,
    'identityVerification': identityVerification,
    'wallet': wallet,
    'preferences': preferences,
    'paymentMethods': paymentMethods,
    'rating': rating,
    'totalRentsMade': totalRentsMade,
    'totalRentsReceived': totalRentsReceived,
    'blocked': blocked,
    'banReason': banReason,
    'reports': reports,
    'notesByAdmin': notesByAdmin,
  };

  /// Facilita clonar y cambiar campos puntuales
  UserModel copyWith({
    String? fullName,
    String? profileImageUrl,
    DateTime? lastLoginAt,
    Map<String, dynamic>? preferences,
    int? rating,
    // añade aquí otros campos que necesites mutar...
  }) {
    return UserModel(
      userId: userId,
      fullName: fullName ?? this.fullName,
      username: username,
      email: email,
      phone: phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      role: role,
      createdAt: createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      address: address,
      identityVerification: identityVerification,
      wallet: wallet,
      preferences: preferences ?? this.preferences,
      paymentMethods: paymentMethods,
      rating: rating ?? this.rating,
      totalRentsMade: totalRentsMade,
      totalRentsReceived: totalRentsReceived,
      blocked: blocked,
      banReason: banReason,
      reports: reports,
      notesByAdmin: notesByAdmin,
    );
  }
}
