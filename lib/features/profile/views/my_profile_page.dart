import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth/services/auth_service.dart';
import '../../auth/ models/user_model.dart';
import '../widgets/my_profile.dart';
import '../../../core/widgets/navbar.dart';
import '../../../core/widgets/footer.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fbUser = FirebaseAuth.instance.currentUser;
    if (fbUser == null) {
      return const Scaffold(
        body: Center(
          child: Text('No user logged in'),
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF1F1F1F),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          // Navbar muestra el email del usuario
          child: Navbar(email: fbUser.email ?? ''),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // ─── Contenido centrado ────────────────────────────
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: StreamBuilder<UserModel>(
                      stream: AuthService().userStream(fbUser.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError || !snapshot.hasData) {
                          return const Center(
                            child: Text(
                              'Error loading profile',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }
                        final user = snapshot.data!;
                        return MyProfile(
                          user: user,
                          onEditProfile: () {
                            Navigator.pushNamed(context, '/profile_settings');
                          },
                          onVerifyAccount: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                  Text('Verify Account tapped')),
                            );
                          },
                          onAddProduct: () {
                            Navigator.pushNamed(context, '/add-product');
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),

              // ─── Footer full width ─────────────────────────────
              const FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}
