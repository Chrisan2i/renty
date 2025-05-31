// lib/features/landing/widgets/footer_section_mobile.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterSectionMobile extends StatelessWidget {
  const FooterSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111111),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo & slogan
          Center(
            child: Column(
              children: [
                Image.network(
                  'https://placehold.co/120x40.png',
                  width: 120,
                  errorBuilder: (context, error, stack) => const Icon(
                    Icons.broken_image,
                    color: Colors.white54,
                    size: 120,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 220,
                  child: Text(
                    'Making rentals easy and accessible for everyone',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF999999),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Secciones apiladas
          _footerColumn('Categories', [
            'Tools',
            'Vehicles',
            'Electronics',
            'Sports',
            'Home & Garden',
          ]),
          const SizedBox(height: 24),
          _footerColumn('Company', [
            'About Us',
            'Careers',
            'Blog',
            'Contact',
          ]),
          const SizedBox(height: 24),
          _footerColumn('Follow Us', [
            'Twitter',
            'Facebook',
            'Instagram',
          ]),
          const SizedBox(height: 32),
          Divider(color: Colors.white.withOpacity(0.2)),
          const SizedBox(height: 16),
          Center(
            child: Text(
              '© 2025 Renty. All rights reserved.',
              style: GoogleFonts.inter(
                color: const Color(0xFF999999),
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: const Color(0xFF0085FF),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            item,
            style: GoogleFonts.inter(
              color: const Color(0xFF999999),
              fontSize: 14,
            ),
          ),
        )),
      ],
    );
  }
}
