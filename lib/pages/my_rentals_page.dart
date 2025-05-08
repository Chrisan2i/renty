import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/landing/my_rentals.dart';
import 'package:renty/widgets/navbar.dart';
import 'package:renty/widgets/footer.dart';



class MyRentalsPage extends StatelessWidget {
  const MyRentalsPage({super.key});

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
              Navbar(email: email),
              MyRentals(),
              FooterSection(),
            ],
          ),
        );
      },
    );
  }
}