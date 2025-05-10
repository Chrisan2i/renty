import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111111),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row with columns
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo & slogan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Después (el mismo placeholder pero en .png):
                  Image.network(
                    'https://placehold.co/120x40.png',
                    width: 120,
                    // opcional: fallback si algo falla
                    errorBuilder: (context, error, stack) => const Icon(
                      Icons.broken_image,
                      color: Colors.white54,
                      size: 120,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 180,
                    child: Text(
                      'Making rentals easy and accessible for everyone',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF999999),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              // Categories
              _footerColumn('Categories', [
                'Tools',
                'Vehicles',
                'Electronics',
                'Sports',
                'Home & Garden',
              ]),
              // Company
              _footerColumn('Company', [
                'About Us',
                'Careers',
                'Blog',
                'Contact',
              ]),
              // Follow Us
              _footerColumn('Follow Us', [
                'Twitter',
                'Facebook',
                'Instagram',
              ]),
            ],
          ),
          const SizedBox(height: 40),
          Divider(color: Colors.white.withOpacity(0.2)),
          const SizedBox(height: 16),
          Center(
            child: Text(
              '© 2025 Renty. All rights reserved.',
              style: GoogleFonts.inter(
                color: const Color(0xFF999999),
                fontSize: 16,
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
              fontSize: 16,
            ),
          ),
        )),
      ],
    );
  }
}