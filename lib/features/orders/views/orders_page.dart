import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/features/orders/widgets/orders.dart';
import 'package:renty/core/widgets/navbar/navbar.dart';
import 'package:renty/core/widgets/footer.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final email = user?.email ?? 'Guest';

        return Scaffold(
          body: ListView(
            children: [
              Navbar(email: email,onToggleTheme: () {
                // Aquí puedes cambiar el tema. Si usas Provider o Bloc, lo conectas aquí.
                print('Cambiar tema (modo claro/oscuro)');
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: const Orders(),
              ),
              FooterSection(),
            ],
          ),
        );
      },
    );
  }
}