import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfile extends StatelessWidget {
  final User user;
  const MyProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final displayName = user.displayName ?? user.email?.split('@').first ?? 'Usuario';
    final email = user.email ?? '';
    final uid = user.uid;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1100),
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FOTO + INFO
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image: NetworkImage("https://placehold.co/120x120"),
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 3, color: Color(0xFF0085FF)),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: const [
                          Icon(Icons.star, size: 16, color: Color(0xFF0085FF)),
                          SizedBox(width: 4),
                          Text('4.9', style: TextStyle(color: Colors.white, fontSize: 14)),
                          SizedBox(width: 6),
                          Text('(124 reviews)', style: TextStyle(color: Color(0xFF999999), fontSize: 14)),
                          SizedBox(width: 6),
                          Text('Miembro desde marzo 2022', style: TextStyle(color: Color(0xFF999999), fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'San Francisco, CA',
                        style: const TextStyle(color: Color(0xFF999999), fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Apasionado por compartir herramientas útiles con mi comunidad.',
                        style: TextStyle(color: Color(0xFF999999), fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0085FF),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            ),
                            child: const Text('Editar Perfil'),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            ),
                            child: const Text('Verificar Cuenta', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white12),
            const SizedBox(height: 12),
            Text(
              'UID: $uid',
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

