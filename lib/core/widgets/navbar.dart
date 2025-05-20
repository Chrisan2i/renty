import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renty/features/products/views/search_page.dart';
import '../../features/landing/views/landing_page.dart';
import 'package:renty/features/profile/views/profile_settings_page.dart';
import 'package:renty/features/profile/views/my_profile_page.dart';
import 'package:renty/features/rentals/views/my_rentals_page.dart';

class Navbar extends StatelessWidget {
  final String email;

  const Navbar({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.black.withAlpha(242),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo con navegación
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LandingPage()),
                  );
                },
                child: Image.asset(
                  'assets/logo.png',
                  height: 40,
                ),
              ),
              // Nav items + buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _navButton('Home', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LandingPage()),
                    );
                  }),
                  _navButton('Category', () {
                    Navigator.pushReplacementNamed(context, '/search');
                  }),
                  _navItem('How It Works'),
                  _navItem('About'),
                  const SizedBox(width: 20),
                  if (user != null) ...[
                    const SizedBox(width: 10),
                    _userMenu(context),
                  ] else ...[
                    _navButton('Sign In', () {
                      Navigator.pushReplacementNamed(context, '/login');
                    }),
                    const SizedBox(width: 10),
                    _primaryButton('Get Started', () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    }),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        title,
        style: GoogleFonts.inter(
          color: const Color(0xFF999999),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _navButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: const Color(0xFF999999),
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _primaryButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0085FF),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _userMenu(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    const defaultImageUrl = 'https://res.cloudinary.com/do9dtxrvh/image/upload/v1742413057/Untitled_design_1_hvuwau.png';

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
      builder: (context, snapshot) {
        String? profileImageUrl;
        if (snapshot.hasData && snapshot.data != null) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          profileImageUrl = data?['profileImageUrl'] as String?;
        }

        return PopupMenuButton<int>(
          offset: const Offset(0, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: const Color(0xFF333333),
          icon: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF0288D1), // Borde azul más oscuro
                width: 1, // Borde más delgado
              ),
            ),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[800],
              child: user == null
                  ? const Icon(Icons.person, color: Colors.white)
                  : ClipOval(
                child: Image.network(
                  profileImageUrl ?? defaultImageUrl,
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 0,
              child: Row(
                children: const [
                  Icon(Icons.account_circle, color: Colors.white70),
                  SizedBox(width: 10),
                  Text("Profile", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            PopupMenuItem(
              value: 1,
              child: Row(
                children: const [
                  Icon(Icons.settings, color: Colors.white70),
                  SizedBox(width: 10),
                  Text("Settings", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Row(
                children: const [
                  Icon(Icons.shopping_bag, color: Colors.white70),
                  SizedBox(width: 10),
                  Text("My Rentals", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem(
              value: 3,
              child: Row(
                children: const [
                  Icon(Icons.logout, color: Colors.redAccent),
                  SizedBox(width: 10),
                  Text("Logout", style: TextStyle(color: Colors.redAccent)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfilePage()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileSettingsPage()),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyRentalsPage()),
                );
                break;
              case 3:
                FirebaseAuth.instance.signOut();
                break;
            }
          },
        );
      },
    );
  }
}