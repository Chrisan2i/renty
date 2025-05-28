import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/features/products/models/product_model.dart';
import 'package:renty/features/rentals/models/rental_request_model.dart';
import 'package:renty/features/rentals/services/rental_request_service.dart';
import 'package:renty/features/rentals/views/send_request_page.dart';
import 'package:renty/features/rentals/widgets/send_request.dart';

class Product extends StatefulWidget {
  final ProductModel product;

  const Product({Key? key, required this.product}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> _fetchOwnerData(String ownerId) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(ownerId).get();
    if (doc.exists) {
      return doc.data();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final List<String> images = product.images.where((url) => url.isNotEmpty).toList();
    final bool isCarousel = images.length > 1;

    final String descriptionText = product.description;

    final Map<String, dynamic>? locMap = product.location;
    final String city = locMap?['city']?.toString() ?? '';
    final String country = locMap?['country']?.toString() ?? '';
    final double? lat = locMap != null && locMap['latitude'] is num
        ? (locMap['latitude'] as num).toDouble()
        : null;
    final double? lon = locMap != null && locMap['longitude'] is num
        ? (locMap['longitude'] as num).toDouble()
        : null;
    final String builtAddress = [city, country].where((s) => s.isNotEmpty).join(', ');
    String locationDisplay;
    if (builtAddress.isNotEmpty) {
      locationDisplay = builtAddress;
    } else if (lat != null && lon != null) {
      locationDisplay = '$lat, $lon';
    } else {
      locationDisplay = '';
    }

    final String category = product.category;

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: 1272,
          height: 2600,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 1272,
                  height: 2600,
                  decoration: const BoxDecoration(color: Color(0xFF111111)),
                ),
              ),

              // 🔁 Carrusel de imágenes
              Positioned(
                left: 72,
                top: 85,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 1128,
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF222222),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: images.length,
                        onPageChanged: (index) {
                          setState(() => _currentIndex = index);
                        },
                        itemBuilder: (context, index) {
                          return Image.network(
                            images[index],
                            width: 1128,
                            height: 500,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    if (isCarousel)
                      Positioned(
                        left: 16,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            if (_currentIndex > 0) {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                    if (isCarousel)
                      Positioned(
                        right: 16,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                          onPressed: () {
                            if (_currentIndex < images.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        ),
                      ),
                  ],
                ),
              ),

              // 📦 Detalles del producto
              Positioned(
                left: 72,
                top: 633,
                child: Container(
                  width: 1128,
                  height: 394,
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
                ),
              ),
              Positioned(
                left: 105,
                top: 666,
                child: Text(
                  product.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
              ),
              Positioned(
                left: 105,
                top: 730,
                child: Row(
                  children: [
                    const Text('★', style: TextStyle(color: Color(0xFF0085FF), fontSize: 16, height: 1.5)),
                    const SizedBox(width: 4),
                    Text(
                      product.rating.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${product.totalReviews} reviews)',
                      style: const TextStyle(color: Color(0xFF999999), fontSize: 16, height: 1.5),
                    ),
                    if (locationDisplay.isNotEmpty) ...[
                      const SizedBox(width: 16),
                      Text(
                        locationDisplay,
                        style: const TextStyle(color: Color(0xFF999999), fontSize: 16, height: 1.5),
                      ),
                    ],
                    if (category.isNotEmpty) ...[
                      const SizedBox(width: 16),
                      Text(
                        category,
                        style: const TextStyle(color: Color(0xFF999999), fontSize: 16, height: 1.5),
                      ),
                    ],
                  ],
                ),
              ),
              Positioned(
                left: 105,
                top: 781,
                child: SizedBox(
                  width: 984,
                  child: Text(
                    descriptionText,
                    style: const TextStyle(color: Color(0xFF999999), fontSize: 18, height: 1.56),
                  ),
                ),
              ),
              Positioned(
                left: 105,
                top: 910,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${product.pricePerDay.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Color(0xFF0085FF),
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        '/day',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 1029,
                top: 938,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SendRequestPage(
                          productId: product.productId,
                          ownerId: product.ownerId,
                          pricePerDay: product.pricePerDay,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 137,
                    height: 56,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF0085FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Rent Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),

              // 🗨️ Reseñas
              Positioned(
                left: 72,
                top: 1051,
                child: Container(
                  width: 1128,
                  height: 255,
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
                ),
              ),
              Positioned(
                left: 105,
                top: 1084,
                child: const Text(
                  'Customer Reviews',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
              ),
              Positioned(
                left: 113,
                top: 1128,
                child: Text(
                  '${product.rating} out of 5',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
              ),
              Positioned(
                left: 208,
                top: 1128,
                child: Text(
                  'Based on ${product.totalReviews} reviews',
                  style: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
              Positioned(
                left: 559,
                top: 1233,
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Show More Reviews',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0085FF),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                ),
              ),

              // 👤 Dueño del producto
              FutureBuilder<Map<String, dynamic>?>(
                future: _fetchOwnerData(product.ownerId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Positioned(
                      left: 72,
                      top: 1340,
                      child: CircularProgressIndicator(),
                    );
                  }
                  final owner = snapshot.data;
                  if (owner == null) return const SizedBox.shrink();

                  return Positioned(
                    left: 72,
                    top: 1340,
                    child: Container(
                      width: 1128,
                      height: 180,
                      decoration: BoxDecoration(
                        color: const Color(0xFF222222),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.26)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 32),
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(owner['profileImageUrl'] ?? ''),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  owner['fullName'] ?? 'Unknown',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Member since ${owner['memberSince'] ?? '2021'}',
                                  style: const TextStyle(
                                    color: Color(0xFF999999),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Color(0xFF0085FF), size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${(owner['rating'] ?? 4.9).toStringAsFixed(1)} (156 reviews)',
                                      style: const TextStyle(color: Colors.white, fontSize: 14),
                                    ),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.access_time, color: Colors.white, size: 16),
                                    const SizedBox(width: 4),
                                    const Text('Responds within 1 hour', style: TextStyle(color: Colors.white, fontSize: 14)),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.check_circle, color: Colors.white, size: 16),
                                    const SizedBox(width: 4),
                                    const Text('98% completion', style: TextStyle(color: Colors.white, fontSize: 14)),
                                    const SizedBox(width: 16),
                                    const Icon(Icons.verified_user, color: Colors.white, size: 16),
                                    const SizedBox(width: 4),
                                    const Text('Verified', style: TextStyle(color: Colors.white, fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Messaging feature coming soon')),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF0085FF),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                            child: const Text(
                              'Message Owner',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 32),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}