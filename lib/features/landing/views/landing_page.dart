import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/category_section.dart';
import '../widgets//how_it_works.dart';
import '../widgets//testimonial.dart';
import '../../../core/widgets/footer.dart';

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
              Navbar(
                email: email,
                onToggleTheme: () {
                  // Aquí puedes cambiar el tema. Si usas Provider o Bloc, lo conectas aquí.
                  print('Cambiar tema (modo claro/oscuro)');
                },
              ),
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