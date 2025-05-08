import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductService {
  final _productsRef = FirebaseFirestore.instance.collection('products');

  Future<void> addProduct(ProductModel product) async {
    final docRef = _productsRef.doc();
    final productWithId = product.copyWith(productId: docRef.id);
    await docRef.set(productWithId.toJson());
  }

  Future<List<ProductModel>> getAllProducts() async {
    final query = await _productsRef.orderBy('createdAt', descending: true).get();
    return query.docs.map((doc) => ProductModel.fromJson(doc.data())).toList();
  }

  Future<void> deleteProduct(String productId) async {
    await _productsRef.doc(productId).delete();
  }
}
