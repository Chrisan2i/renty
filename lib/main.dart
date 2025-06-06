import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renty/features/search/view/search_page.dart';
import 'package:renty/features/profile/views/my_profile_page.dart';
import 'package:renty/features/profile/views/account_verification_view.dart';
import 'package:renty/features/profile/views/verification_status_view.dart';
import 'package:renty/features/rentals/views/rentals_page.dart';
import 'features/landing/views/landing_page.dart';
import 'package:renty/features/auth/widgets/login.dart';
import 'package:renty/features/auth/widgets/sign_up.dart';
import 'package:renty/features/add_product/view/add_product_page.dart';
import 'package:renty/features/products/views/product_list_page.dart';
import 'package:renty/features/chat/views/inbox_page.dart';
import 'package:renty/features/profile/views/profile_settings_page.dart';
import 'package:renty/firebase_options.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'package:renty/core/providers/theme_provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const RentyApp(),
    ),
  );

}

class RentyApp extends StatelessWidget {
  const RentyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Renty',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          initialRoute: '/landing',
          routes: {
            '/landing': (context) => const LandingPage(),
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignUpScreen(),
            '/profile': (context) => const MyProfilePage(),
            '/search': (c) {
              final slug = ModalRoute.of(c)!.settings.arguments as String?;
              return SearchPage(
                initialSelectedCategories: slug == null ? [] : [slug],
              );
            },
            '/myrentals': (context) => const MyRentalsPage(),
            '/add-product': (context) => const AddProductPage(),
            '/product-list': (context) => const ProductListPage(),
            '/inbox': (context) => const InboxPage(),
            '/profile_settings': (context) => const ProfileSettingsPage(),
            '/account-verification': (context) => const AccountVerificationView(),
            '/verification-status': (context) => const VerificationStatusView(),
          },
        );
      },
    );
  }
}