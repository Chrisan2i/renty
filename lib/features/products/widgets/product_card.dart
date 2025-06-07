import 'package:flutter/material.dart';
import 'package:renty/features/products/models/product_model.dart';
import 'package:renty/features/products/views/product_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  void _navigateToDetails(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Please log in'),
          content: const Text('You must be logged in to rent a product.'),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pushNamed('/login');
              },
              child: const Text('Log In'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pushNamed('/signup');
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.images.isNotEmpty ? product.images.first : 'https://placehold.co/400x300';
    final city = (product.location['city'] ?? '').toString().trim();
    final state = (product.location['state'] ?? '').toString().trim();
    final locationText = (city.isNotEmpty || state.isNotEmpty) ? '$city, $state' : 'Location not specified';

    final rentalLabels = {
      'hour': 'hr',
      'day': 'day',
      'week': 'wk',
      'month': 'mo',
    };

    final rentalText = product.rentalPrices.entries.map((e) {
      final label = rentalLabels[e.key] ?? e.key;
      return '\$${e.value.toStringAsFixed(0)}/$label';
    }).join(' • ');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 4),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _navigateToDetails(context),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.network(
                  'https://placehold.co/400x300',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFF0085FF), size: 18),
                    const SizedBox(width: 4),
                    Text(
                      product.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () => _navigateToDetails(context),
                  child: Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFFAAAAAA)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        locationText,
                        style: const TextStyle(
                          color: Color(0xFFAAAAAA),
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  rentalText,
                  style: const TextStyle(
                    color: Color(0xFF0085FF),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _navigateToDetails(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0085FF),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 3,
                      shadowColor: Colors.black45,
                    ),
                    child: const Text(
                      'Rent Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),
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
