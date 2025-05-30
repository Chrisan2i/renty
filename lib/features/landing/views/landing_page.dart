import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/widgets/navbar/navbar.dart';

import '../widgets/hero_section.dart';
import '../widgets/category_section.dart';
import '../widgets/how_it_works.dart';
import '../widgets/testimonial.dart';
import '../../../core/widgets/footer.dart';


import '../../../core/widgets_mobile/drawer_mobile.dart';
import '../../../core/widgets_mobile/responsive_helper.dart';

import '../widgets_mobile/hero_section_mobile.dart';
import '../widgets_mobile/category_section_mobile.dart';
import '../widgets_mobile/how_it_works_section_mobile.dart';
import '../widgets_mobile/testimonial_section_mobile.dart';
import '../../../core/widgets_mobile/footer_section_mobile.dart';





class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final email = user?.email ?? 'Guest';

        return Scaffold(
          appBar: isMobile
              ? AppBar(
            title: const Text('Renty'),
            backgroundColor: Colors.black,
          )
              : null,
          drawer: isMobile ? const RentyDrawer() : null,
          body: Column(
            children: [
              if (!isMobile)
                Navbar(
                  email: email,
                  onToggleTheme: () {
                    // lógica para cambiar tema (opcional)
                  },
                ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    isMobile ? const HeroSectionMobile() : const HeroSection(),
                    isMobile ? const CategorySectionMobile() : CategorySection(),
                    isMobile ? const HowItWorksSectionMobile() : const HowItWorksSection(),
                    isMobile ? const TestimonialSectionMobile() : const TestimonialSection(),
                    isMobile ? const FooterSectionMobile() : const FooterSection(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
