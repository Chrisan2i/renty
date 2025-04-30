import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  final List<Map<String, dynamic>> steps = const [
    {
      'emoji': '🔍',
      'title': 'Find What You Need',
      'desc': 'Browse thousands of items available for rent in your area',
    },
    {
      'emoji': '📅',
      'title': 'Book & Pay',
      'desc': 'Select your rental period and make secure payment',
    },
    {
      'emoji': '🤝',
      'title': 'Pick Up & Return',
      'desc': 'Meet the owner, get your item, and return when done',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111111),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
      child: Column(
        children: [
          Text(
            'How It Works',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 48,
            runSpacing: 48,
            alignment: WrapAlignment.center,
            children: steps.map((step) {
              return Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0085FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      step['emoji'],
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    step['title'],
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 300,
                    child: Text(
                      step['desc'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF999999),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}