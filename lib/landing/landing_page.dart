import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'navbar.dart';
import 'hero_section.dart';
import 'category_section.dart';
import 'how_it_works.dart';
import 'testimonial.dart';
import 'footer.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
              HeroSection(),
              CategorySection(),
              HowItWorksSection(),
              TestimonialSection(),
              FooterSection(),
            ],
          ),
        );
      },
    );
  }
}
