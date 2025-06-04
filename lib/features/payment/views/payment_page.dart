import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/features/payment/widgets/payment.dart';
import 'package:renty/core/widgets/navbar/navbar.dart';
import 'package:renty/core/widgets/footer.dart';

class PaymentPage extends StatelessWidget {
  final String requestId;

  const PaymentPage({super.key, required this.requestId});

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
              Payment(requestId: requestId),
              FooterSection(),
            ],
          ),
        );
      },
    );
  }
}