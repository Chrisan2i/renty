import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'landing/landing_page.dart';

void main() {
  runApp(const ToolShareApp());
}

class ToolShareApp extends StatelessWidget {
  const ToolShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToolShare',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF111111),
        primaryColor: const Color(0xFF0085FF),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const LandingPage(),
    );
  }
}
