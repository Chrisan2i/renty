import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renty/models/product_model.dart';

class ProductService {
  final _productsRef = FirebaseFirestore.instance.collection('products');

  // Cachea siempre la última lista recibida por el Stream
  List<ProductModel> _lastFetchedProducts = [];
  List<ProductModel> get lastFetchedProducts => _lastFetchedProducts;

  Future<void> addProduct(ProductModel product) async {
    final docRef = _productsRef.doc();
    final productWithId = product.copyWith(productId: docRef.id);
    await docRef.set(productWithId.toJson());
  }

  Stream<List<ProductModel>> getAllProductsStream() {
    return _productsRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      final list = snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
      // Actualiza el cache
      _lastFetchedProducts = list;
      return list;
    });
  }

  Future<void> deleteProduct(String productId) async {
    await _productsRef.doc(productId).delete();
  }
}
