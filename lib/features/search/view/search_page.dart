// lib/features/products/views/search_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/features/search/widgets/search.dart';
import 'package:renty/core/widgets/navbar/navbar.dart';
import 'package:renty/core/widgets/footer.dart';

class SearchPage extends StatelessWidget {
  final List<String> initialSelectedCategories;

  const SearchPage({
    super.key,
    this.initialSelectedCategories = const [],
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final email = snapshot.data?.email ?? 'Guest';

        return Scaffold(
          body: ListView(
            children: [
              Navbar(email: email,onToggleTheme: () {
                // Aquí puedes cambiar el tema. Si usas Provider o Bloc, lo conectas aquí.
                print('Cambiar tema (modo claro/oscuro)');
              },
              ),
              // Le pasamos la lista inicial de slugs:
              Search(initialSelectedCategories: initialSelectedCategories),
              FooterSection(),
            ],
          ),
        );
      },
    );
  }
}
