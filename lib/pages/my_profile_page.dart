import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/mains/my_profile.dart';
import 'package:renty/widgets/navbar.dart';
import 'package:renty/widgets/footer.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;
        if (user == null) {
          // Redirigir automáticamente al landing
          Future.microtask(() {
            Navigator.pushReplacementNamed(context, '/landing');
          });
          return const SizedBox(); // Retornar un widget vacío mientras se redirige
        }

        return Scaffold(
          body: ListView(
            children: [
              Navbar(email: user.email ?? 'Invitado'),
              MyProfile(user: user),
              const FooterSection(),
            ],
          ),
        );
      },
    );
  }
}

