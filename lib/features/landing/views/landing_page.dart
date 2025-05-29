import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/widgets/navbar/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/category_section.dart';
import '../widgets/how_it_works.dart';
import '../widgets/testimonial.dart';
import '../../../core/widgets/footer.dart';
import '../../../core/widgets/navbar_app/renty_drawer.dart';
import '../../../core/utils/responsive_helper.dart';

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
                  children: const [
                    HeroSection(),
                    CategorySection(),
                    HowItWorksSection(),
                    TestimonialSection(),
                    FooterSection(),
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

