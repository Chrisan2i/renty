import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/features/profile/widgets/profile_settings.dart';
import 'package:renty/core/widgets/navbar.dart';
import 'package:renty/core/widgets/footer.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

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
              Navbar(email: user.email ?? 'Invitado',onToggleTheme: () {
            // Aquí puedes cambiar el tema. Si usas Provider o Bloc, lo conectas aquí.
            print('Cambiar tema (modo claro/oscuro)');
          },
          ),
              ProfileSettings(user: user),
              const FooterSection(),
            ],
          ),
        );
      },
    );
  }
}
