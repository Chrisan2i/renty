import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      color: Colors.black.withOpacity(0.95),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Image.network(
            'https://placehold.co/120x40',
            width: 120,
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
              TextButton(
                onPressed: () {},
                child: Text(
                  'Sign In',
                  style: GoogleFonts.inter(color: const Color(0xFF999999)),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {},
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
          )
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
