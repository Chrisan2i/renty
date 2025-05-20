import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/widgets/navbar.dart';
import '../../../core/widgets/footer.dart';
import '../widgets/add_product.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF1F1F1F),
        body: const Center(
          child: Text(
            'Por favor, inicia sesión para añadir un producto',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Navbar(email: fbUser.email ?? ''),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Contenido centrado y limitado a 800px
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: const AddProduct(),
              ),
              // Footer al final del contenido desplazable
              const SizedBox(height: 24), // Espacio adicional
              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}