import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/features/rentals/widgets/send_request.dart';
import 'package:renty/core/widgets/navbar/navbar.dart';
import 'package:renty/core/widgets/footer.dart';

class SendRequestPage extends StatelessWidget {
  final String productId;
  final String ownerId;
  final double pricePerDay;

  const SendRequestPage({
    super.key,
    required this.productId,
    required this.ownerId,
    required this.pricePerDay,
  });

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
              Navbar(email: email, onToggleTheme: () {
                print('Cambiar tema (modo claro/oscuro)');
              }),
              SendRequest(
                productId: productId,
                ownerId: ownerId,
                pricePerDay: pricePerDay,
              ),
              FooterSection(),
            ],
          ),
        );
      },
    );
  }
}
