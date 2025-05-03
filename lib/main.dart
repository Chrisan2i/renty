import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renty/landing/my_rentals_page.dart';
import 'landing/landing_page.dart';
import 'landing/login.dart';
import '/landing/auth/auth_gate.dart';
import 'landing/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'landing/my_rentals_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // Inicializacion para Web
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyD8tWm3W_SYVHyWSJH3u7CMHXltW_J3c2Y",
        authDomain: "renty-a5491.firebaseapp.com",
        projectId: "renty-a5491",
        storageBucket: "renty-a5491.firebasestorage.app",
        messagingSenderId: "870870389735",
        appId: "1:870870389735:web:ac64b53c0ce5f3757ba342",
      ),
    );
  } else {
    //Inicializacion para Android (usa google-services.json)
    await Firebase.initializeApp();
  }

  runApp(const RentyApp());
}

class RentyApp extends StatelessWidget {
  const RentyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Renty',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF111111),
        primaryColor: const Color(0xFF0085FF),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      initialRoute: '/landing',
      routes: {
        '/landing': (context) => const LandingPage(), // sin login
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const LandingPage(),
        '/myrentals': (context) => const MyRentalsPage(),
      },
    );
  }

}