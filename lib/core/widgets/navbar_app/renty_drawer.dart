import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renty/features/search/view/search_page.dart';
import 'package:renty/features/profile/views/my_profile_page.dart';
import 'package:renty/features/profile/views/profile_settings_page.dart';
import 'package:renty/features/rentals/views/my_rentals_page.dart';
import 'package:renty/features/rentals/views/my_rental_requests_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RentyDrawer extends StatelessWidget {
  const RentyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: const Color(0xFF0B0B0B),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            Row(
              children: [
                Image.asset('assets/logo.png', height: 36),
                const SizedBox(width: 12),
                Text(
                  'Menú',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _drawerItem(
              icon: Icons.search,
              label: 'Artículos',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchPage())),
            ),
            _drawerItem(
              icon: Icons.shopping_cart,
              label: 'Mis Rentas',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyRentalsPage())),
            ),
            _drawerItem(
              icon: Icons.inbox,
              label: 'Solicitudes',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyRentalRequestsPage())),
            ),
            _drawerItem(
              icon: Icons.settings,
              label: 'Configuración',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileSettingsPage())),
            ),
            _drawerItem(
              icon: Icons.person,
              label: 'Perfil',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyProfilePage())),
            ),
            const Divider(color: Colors.white30, height: 32),
            if (user != null)
              _drawerItem(
                icon: Icons.logout,
                label: 'Cerrar sesión',
                color: Colors.redAccent,
                onTap: () => FirebaseAuth.instance.signOut(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.white,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      hoverColor: Colors.white10,
    );
  }
}
