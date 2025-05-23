import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/core/widgets/navbar.dart';
import 'package:renty/features/products/widgets/product.dart';
import 'package:renty/core/widgets/footer.dart';
import 'package:renty/features/products/models/product_model.dart';

class ProductPage extends StatelessWidget {
  final ProductModel product;

  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        final user = snapshot.data;
        final email = user?.email ?? 'Guest';

        return Scaffold(
          body: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Navbar(email: email),
              Product(product: product),
              FooterSection(),
            ],
          ),
        );
      },
    );
  }
}