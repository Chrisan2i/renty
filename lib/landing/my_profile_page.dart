import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'my_profile.dart';
import 'navbar.dart';
import 'footer.dart';

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
          return const Center(child: Text('Please sign in to view your profile'));
        }

        return Scaffold(
          body: ListView(
            children: [
              Navbar(email: user.email ?? 'Guest'),
              MyProfile(user: user),
              const FooterSection(),
            ],
          ),
        );
      },
    );
  }
}