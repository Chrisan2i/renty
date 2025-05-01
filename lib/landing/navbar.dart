import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'sign_up.dart';

class Navbar extends StatelessWidget {
  final String email;

  const Navbar({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      color: Colors.black.withOpacity(0.95),
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
            children: [
              _navItem('Home'),
              _navItem('Categories'),
              _navItem('How It Works'),
              _navItem('About'),
              const SizedBox(width: 20),

              // Mostrar info solo si el usuario está logueado
              if (email != null) ...[
                const SizedBox(width: 10),
                PopupMenuButton<int>(
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
                      // Navegar a Profile
                        break;
                      case 1:
                      // Navegar a Settings
                        break;
                      case 2:
                      // Navegar a My Rentals
                        break;
                      case 3:
                        FirebaseAuth.instance.signOut();
                        break;
                    }
                  },
                ),
              ]
              else ...[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: GoogleFonts.inter(color: const Color(0xFF999999)),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUpScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0085FF),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ],
          ),
        ],
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
}
