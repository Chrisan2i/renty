import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renty/features/products/models/product_model.dart';

class ProductService {
  /// Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Reference to the `products` collection
  final CollectionReference<Map<String, dynamic>> _productsRef =
  FirebaseFirestore.instance.collection('products');

  /// Cachea siempre la última lista recibida por el Stream
  List<ProductModel> _lastFetchedProducts = [];
  List<ProductModel> get lastFetchedProducts => _lastFetchedProducts;

  /// Agrega un nuevo producto, generando un ID y copiándolo al modelo antes de guardar
  Future<void> addProduct(ProductModel product) async {
    final docRef = _productsRef.doc();
    final productWithId = product.copyWith(productId: docRef.id);
    await docRef.set(productWithId.toJson());
  }

  /// Recupera una única vez el producto con [productId],
  /// inyectando el ID en el mapa antes de llamar a fromJson.
  Future<ProductModel> getProductOnce(String productId) async {
    final snapshot = await _db
        .collection('products')
        .doc(productId)
        .get();

    if (!snapshot.exists) {
      throw Exception('Producto no encontrado');
    }

    final data = snapshot.data()! as Map<String, dynamic>;
    final json = {
      ...data,
      'productId': snapshot.id,
    };

    return ProductModel.fromJson(json);
  }

  /// Devuelve un Stream de todos los productos ordenados por fecha de creación,
  /// y actualiza el cache interno.
  Stream<List<ProductModel>> getAllProductsStream() {
    return _productsRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      final list = snapshot.docs
          .map((doc) => ProductModel.fromJson({
        ...doc.data(),
        'productId': doc.id,
      }))
          .toList();
      _lastFetchedProducts = list;
      return list;
    });
  }

  /// Elimina el producto con [productId] de Firestore
  Future<void> deleteProduct(String productId) async {
    await _productsRef.doc(productId).delete();
  }
}
