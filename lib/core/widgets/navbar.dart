import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renty/features/products/views/search_page.dart';
import '../../features/landing/views/landing_page.dart';
import 'package:renty/features/profile/views/profile_settings_page.dart';
import 'package:renty/features/profile/views/my_profile_page.dart';
import 'package:renty/features/rentals/views/my_rentals_page.dart';
import '../../features/rentals/views/my_rental_requests_page.dart';

class Navbar extends StatelessWidget {
  final String email;
  final VoidCallback onToggleTheme;

  const Navbar({super.key, required this.email, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: const Color(0xFF0B0B0B),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1400),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LandingPage()),
                    ),
                    child: Image.asset(
                      'assets/logo.png',
                      height: 45,
                    ),
                  ),
                  const SizedBox(width: 24),
                  _navItem('Artículos', () {
                    Navigator.pushReplacementNamed(context, '/search');
                  }),
                  _navItem('Rentas', () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MyRentalsPage()));
                  }),
                  _navItem('Solicitudes', () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MyRentalRequestsPage()));
                  }),
                  _navItem('Ordenes', () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const LandingPage()));
                  }),
                ],
              ),
              Row(
                children: [
                  if (user != null) ...[
                    _iconButton(Icons.search, () {}),
                    _notificationIcon(),
                    _iconButton(Icons.dark_mode, onToggleTheme),
                    const SizedBox(width: 8),
                    _primaryButton('Publicar', () {
                      // Acción para publicar
                    }),
                    const SizedBox(width: 12),
                    _userMenu(context),
                  ] else ...[
                    _navItem('Iniciar Sesión', () {
                      Navigator.pushReplacementNamed(context, '/login');
                    }),
                    const SizedBox(width: 8),
                    _primaryButton('Regístrate', () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    }),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(String text, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: const Color(0xFFEAECEF),
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.grey[300], size: 22),
      splashRadius: 20,
    );
  }

  Widget _notificationIcon() {
    // Simulación de notificación activa
    bool hasNotification = true;

    return Stack(
      children: [
        IconButton(
          onPressed: () {
            // Redirigir a página de notificaciones
          },
          icon: const Icon(Icons.notifications, color: Colors.grey, size: 22),
          splashRadius: 20,
        ),
        if (hasNotification)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF0085FF),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  Widget _primaryButton(String text, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.upload, size: 18, color: Colors.black),
      label: Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0085FF),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        elevation: 0,
      ),
    );
  }

  Widget _userMenu(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    const defaultImageUrl = 'https://res.cloudinary.com/do9dtxrvh/image/upload/v1742413057/Untitled_design_1_hvuwau.png';

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
      builder: (context, snapshot) {
        String? profileImageUrl;
        if (snapshot.hasData && snapshot.data != null) {
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          profileImageUrl = data?['profileImageUrl'] as String?;
        }

        return PopupMenuButton<int>(
          offset: const Offset(0, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: const Color(0xFF1E1E1E),
          icon: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey[800],
            child: ClipOval(
              child: Image.network(
                profileImageUrl ?? defaultImageUrl,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
          itemBuilder: (context) => [
            _popupItem(Icons.account_circle, "Mi Perfil", 0),
            _popupItem(Icons.settings, "Configuración", 1),
            _popupItem(Icons.shopping_bag, "Mis Rentas", 2),
            const PopupMenuDivider(),
            _popupItem(Icons.logout, "Cerrar Sesión", 3, color: Colors.redAccent),
          ],
          onSelected: (value) {
            switch (value) {
              case 0:
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MyProfilePage()));
                break;
              case 1:
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileSettingsPage()));
                break;
              case 2:
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MyRentalsPage()));
                break;
              case 3:
                FirebaseAuth.instance.signOut();
                break;
            }
          },
        );
      },
    );
  }

  PopupMenuItem<int> _popupItem(IconData icon, String text, int value, {Color? color}) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: color ?? Colors.white70, size: 18),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: color ?? Colors.white)),
        ],
      ),
    );
  }
}