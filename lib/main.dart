import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renty/features/products/views/search_page.dart';
import 'package:renty/features/profile/views/my_profile_page.dart';
import 'package:renty/features/profile/views/account_verification_view.dart';
import 'package:renty/features/profile/views/verification_status_view.dart';
import 'package:renty/features/rentals/views/my_rentals_page.dart';
import 'features/landing/views/landing_page.dart';
import 'package:renty/features/auth/views/login_page.dart';
import 'package:renty/features/auth/views/sign_up_page.dart';
import 'package:renty/features/products/views/add_product_page.dart';
import 'package:renty/features/products/views/product_list_page.dart';
import 'package:renty/features/rentals/views/rental_requests_page.dart';
import 'package:renty/features/chat/views/inbox_page.dart';
import 'package:renty/features/profile/views/profile_settings_page.dart';
import 'package:renty/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/landing': (context) => const LandingPage(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/profile': (context) => const MyProfilePage(),
        '/search': (c) {
          // 1) Leemos de settings.arguments el slug (String)
          final slug = ModalRoute.of(c)!.settings.arguments as String?;
          // 2) Se lo pasamos al SearchPage
          return SearchPage(
            initialSelectedCategories: slug == null ? [] : [slug],
          );
        },
        '/myrentals': (context) => const MyRentalsPage(),
        '/add-product': (context) => const AddProductPage(),
        '/product-list': (context) => const ProductListPage(),
        '/rental-requests': (context) => const RentalRequestsPage(),
        '/inbox': (context) => const InboxPage(),
        '/profile_settings': (context) => const ProfileSettingsPage(),
        '/account-verification': (context) => const AccountVerificationView(),
        '/verification-status': (context) => const VerificationStatusView(),
      },
    );
  }
}