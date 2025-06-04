import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:renty/features/products/models/product_model.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  Stream<List<ProductModel>> getProductsStream() {
    return FirebaseFirestore.instance
        .collection('products')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Productos disponibles')),
      body: StreamBuilder<List<ProductModel>>(
        stream: getProductsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final products = snapshot.data;

          if (products == null || products.isEmpty) {
            return const Center(child: Text('No hay productos disponibles'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              final price = p.rentalPrices['day'] ?? p.rentalPrices.values.firstOrNull ?? 0.0;

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(p.title),
                  subtitle: Text(p.description),
                  trailing: Text('\$${price.toStringAsFixed(2)}'),
                  onTap: () {
                    // Aquí puedes ir a la pantalla del producto
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
