import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renty/features/categories/models/category_model.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Cache de la última lista obtenida
  List<CategoryModel> lastFetchedCategories = [];

  /// Obtiene todas las categorías activas y las ordena en el cliente
  Future<List<CategoryModel>> getAllCategories() async {
    // 1) Quitamos la llamada a .orderBy('name')
    final snapshot = await _firestore
        .collection('categories')
        .where('isActive', isEqualTo: true)
        .get();

    // 2) Mapeamos a modelos
    final categories = snapshot.docs
        .map((doc) => CategoryModel.fromDocument(doc))
        .toList();

    // 3) Ordenamos alfabéticamente en Dart
    categories.sort((a, b) => a.name.compareTo(b.name));

    // 4) Guardamos en cache y devolvemos
    lastFetchedCategories = categories;
    return categories;
  }
}
