import 'package:flutter/material.dart';
import 'package:renty/features/products/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl =
    product.images.isNotEmpty ? product.images.first : 'https://placehold.co/400x300';
    final city = product.location['city'] ?? '';
    final state = product.location['state'] ?? '';
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.network(
                'https://placehold.co/400x300',
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Detalles
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFF0085FF), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      product.rating.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  product.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '$city, $state',
                  style: const TextStyle(color: Color(0xFF999999), fontSize: 14),
                ),
                const SizedBox(height: 12),
                Text(
                  '\$${product.pricePerDay.toStringAsFixed(0)}/day',
                  style: const TextStyle(
                      color: Color(0xFF0085FF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0085FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: const Text('Rent Now'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
