import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String ownerId;
  final String title;
  final String description;
  final String category;
  final Map<String, double> rentalPrices;
  final List<String> images;
  final bool isAvailable;
  final double rating;
  final int totalReviews;
  final int views; // 👈 NUEVO
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> location;

  ProductModel({
    required this.productId,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.category,
    required this.rentalPrices,
    required this.images,
    required this.isAvailable,
    required this.rating,
    required this.totalReviews,
    required this.views, // 👈 NUEVO
    required this.createdAt,
    required this.updatedAt,
    required this.location,
  });

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'ownerId': ownerId,
    'title': title,
    'description': description,
    'category': category,
    'rentalPrices': rentalPrices,
    'images': images,
    'isAvailable': isAvailable,
    'rating': rating,
    'totalReviews': totalReviews,
    'views': views, // 👈 NUEVO
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'location': location,
  };

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productId: json['productId'],
    ownerId: json['ownerId'],
    title: json['title'],
    description: json['description'],
    category: json['category'],
    rentalPrices: Map<String, double>.from(json['rentalPrices'] ?? {}),
    images: List<String>.from(json['images']),
    isAvailable: json['isAvailable'],
    rating: (json['rating'] ?? 0).toDouble(),
    totalReviews: json['totalReviews'],
    views: json['views'] ?? 0, // 👈 NUEVO
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    location: Map<String, dynamic>.from(json['location']),
  );

  ProductModel copyWith({
    String? productId,
    String? ownerId,
    String? title,
    String? description,
    String? category,
    Map<String, double>? rentalPrices,
    List<String>? images,
    bool? isAvailable,
    double? rating,
    int? totalReviews,
    int? views, // 👈 NUEVO
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? location,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      rentalPrices: rentalPrices ?? this.rentalPrices,
      images: images ?? this.images,
      isAvailable: isAvailable ?? this.isAvailable,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      views: views ?? this.views, // 👈 NUEVO
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      location: location ?? this.location,
    );
  }

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      productId: data['productId'] ?? '',
      ownerId: data['ownerId'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      rentalPrices: Map<String, double>.from(data['rentalPrices'] ?? {}),
      images: List<String>.from(data['images'] ?? []),
      isAvailable: data['isAvailable'] ?? true,
      rating: (data['rating'] ?? 0).toDouble(),
      totalReviews: data['totalReviews'] ?? 0,
      views: data['views'] ?? 0,
      createdAt: DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(data['updatedAt'] ?? '') ?? DateTime.now(),
      location: Map<String, dynamic>.from(data['location'] ?? {}),
    );
  }
}
