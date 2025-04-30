import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Scaffold(
      body: ListView(
        children: const [
          Navbar(),
          HeroSection(),
          CategorySection(),
          HowItWorksSection(),
          TestimonialSection(),
          FooterSection(),
        ],
      ),
    );
  }
}
