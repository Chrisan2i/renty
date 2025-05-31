import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/widgets/navbar/navbar.dart';
import '../../../core/widgets/footer.dart';
import '../add_product.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ✅ Navbar movido aquí
              Navbar(
                email: fbUser.email ?? '',
                onToggleTheme: () {
                  print('Cambiar tema (modo claro/oscuro)');
                },
              ),
              // Contenido centrado y limitado a 800px
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: const AddProduct(),
              ),
              const SizedBox(height: 24),
              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}