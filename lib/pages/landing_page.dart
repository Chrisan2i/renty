import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/navbar.dart';
import '../landing/hero_section.dart';
import '../landing/category_section.dart';
import '../landing/how_it_works.dart';
import '../landing/testimonial.dart';
import '../widgets/footer.dart';

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