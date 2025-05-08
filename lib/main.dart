import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renty/pages/my_profile_page.dart';
import 'package:renty/pages/my_rentals_page.dart';
import 'pages/landing_page.dart';
import 'package:renty/pages/login_page.dart';
import 'package:renty/pages/sign_up_page.dart';
import 'package:renty/pages/add_product_page.dart';
import 'package:renty/pages/product_list_page.dart';
import 'package:renty/pages/rental_requests_page.dart';
import 'package:renty/pages/inbox_page.dart';
import 'package:renty/pages/profile_settings_page.dart';



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
        '/profile': (context) => const MyProfilePage(),
        '/home': (context) => const LandingPage(),
        '/myrentals': (context) => const MyRentalsPage(),
        '/add-product': (context) => const AddProductPage(),
        '/product-list': (context) => const ProductListPage(),
        '/rental-requests': (context) => const RentalRequestsPage(),
        '/inbox': (context) => const InboxPage(),
        '/profile_settings': (context) => const ProfileSettingsPage(),
      },
    );
  }

}