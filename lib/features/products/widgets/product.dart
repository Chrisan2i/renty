import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renty/features/products/models/product_model.dart';

class Product extends StatelessWidget {
  final ProductModel product;

  const Product({Key? key, required this.product}) : super(key: key);

  // Fetch owner data from Firestore by matching userId
  Future<Map<String, dynamic>> _fetchOwnerData(String ownerId) async {
    debugPrint('Using static owner data for testing (ownerId: $ownerId)');
    // Temporarily bypass Firestore to isolate rendering issues
    return {
      'displayName': 'Test User',
      'fotoPerfil': 'https://res.cloudinary.com/do9dtxrvh/image/upload/v1742413057/Untitled_design_1_hvuwau.png'
    };

    debugPrint('Fetching owner data for ownerId: $ownerId');
    try {
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('userId', isEqualTo: ownerId)
          .limit(1)
          .get()
          .timeout(const Duration(seconds: 10));
      debugPrint('Firestore query returned ${query.docs.length} docs');
      if (query.docs.isNotEmpty) {
        final data = query.docs.first.data();
        debugPrint('Owner data found: ${data['displayName']}');
        return data;
      }
      debugPrint('No owner data found for ownerId: $ownerId');
      return {'displayName': 'Unknown User', 'fotoPerfil': null};
    } catch (e, stackTrace) {
      debugPrint('Owner fetch error: $e\n$stackTrace');
      return {'displayName': 'Error', 'fotoPerfil': null};
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Rendering Product widget for: ${product.title} (ID: ${product.productId})');
    final imageUrl = product.images.isNotEmpty
        ? product.images.first
        : 'https://placehold.co/1128x500';
    final location = product.location ?? 'Unknown';

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Imagen principal ---
          Container(
            margin: const EdgeInsets.all(16),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // --- Detalles del producto ---
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
              color: const Color(0xFF222222),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.white.withOpacity(0.26),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '\$${product.pricePerDay.toStringAsFixed(2)} / day',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),

          // --- Información del propietario ---
          FutureBuilder<Map<String, dynamic>>(
            future: _fetchOwnerData(product.ownerId),
            builder: (_, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              final owner = snapshot.data!;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: const Color(0xFF222222),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.white.withOpacity(0.26),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: owner['fotoPerfil'] != null
                          ? NetworkImage(owner['fotoPerfil'])
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          owner['displayName'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Usually responds within 1 hour',
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 16,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),

          // --- Botón “Rent Now” ---
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Rental action TBD')),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF0085FF)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              child: const Text('Rent Now'),
            ),
          ),

          // --- Placeholder de mapa y ubicación ---
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
              color: const Color(0xFF222222),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.white.withOpacity(0.26),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF333333),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Map placeholder',
                      style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 16,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Exact location: $location',
                  style: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
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
