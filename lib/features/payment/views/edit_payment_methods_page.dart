// SE USARA SI SE ELIMINA EL POP UP MENU
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/features/payment/widgets/edit_payment_methods.dart';
import 'package:renty/core/widgets/navbar/navbar.dart';
import 'package:renty/core/widgets/footer.dart';

class EditPaymentMethodsPage extends StatelessWidget {
  const EditPaymentMethodsPage({super.key});

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
              Navbar(
                email: email,
                onToggleTheme: () {
                  print('Cambiar tema (modo claro/oscuro)');
                },
              ),

              FooterSection(),
            ],
          ),
        );
      },
    );
  }
}