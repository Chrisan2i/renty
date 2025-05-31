import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../landing/views/landing_page.dart';
import 'widgets/login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const LandingPage(); // Usuario autenticado
        } else {
          return const LoginScreen(); // Usuario no autenticado
        }
      },
    );
  }
}
