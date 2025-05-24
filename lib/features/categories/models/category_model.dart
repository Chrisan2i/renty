import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String? iconUrl;
  final bool isActive;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    this.iconUrl,
    required this.isActive,
  });

  factory CategoryModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return CategoryModel(
      id: doc.id,
      name: data['name'] as String? ?? '',
      slug: data['slug'] as String? ?? '',
      description: data['description'] as String? ?? '',
      iconUrl: data['iconUrl'] as String?,
      isActive: data['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'slug': slug,
      'description': description,
      'iconUrl': iconUrl,
      'isActive': isActive,
    };
  }
}
