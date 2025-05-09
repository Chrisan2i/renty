import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/pages/search_page.dart';
import '../pages/landing_page.dart';
import 'package:renty/pages/profile_settings_page.dart';
import 'package:renty/pages/my_profile_page.dart';
import 'package:renty/pages/my_rentals_page.dart';

class Navbar extends StatelessWidget {
  final String email;

  const Navbar({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.black.withAlpha(242), // corregido .withOpacity
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Image.asset(
                'assets/logo.png',
                height: 40,
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

                  if (email != null) ...[
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

  // 🔧 Solo se corrigió para aceptar context
  Widget _userMenu(BuildContext context) {
    return PopupMenuButton<int>(
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFF333333),
      icon: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.grey[800],
        backgroundImage: FirebaseAuth.instance.currentUser?.photoURL != null
            ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
            : null,
        child: FirebaseAuth.instance.currentUser?.photoURL == null
            ? const Icon(Icons.person, color: Colors.white)
            : null,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/profile');
            });
          },
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
            children: [
              Icon(Icons.settings, color: Colors.white70),
              SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/profile_settings');
                },
                child: Text("Settings", style: TextStyle(color: Colors.white)),
              ),
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
  }
}
