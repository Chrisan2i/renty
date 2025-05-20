import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../auth/models/user_model.dart';

class MyProfile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onEditProfile;
  final VoidCallback onVerifyAccount;
  final VoidCallback onAddProduct;

  const MyProfile({
    Key? key,
    required this.user,
    required this.onEditProfile,
    required this.onVerifyAccount,
    required this.onAddProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memberSince = DateFormat('MMMM yyyy').format(user.createdAt);
    final city = user.address['city'] ?? '';
    final state = user.address['state'] ?? '';
    final location = [city, state].where((s) => s.isNotEmpty).join(', ');
    final bio = (user.preferences['bio'] as String?) ?? '';
    // URL predeterminada para la imagen de perfil
    const defaultImageUrl = 'https://res.cloudinary.com/do9dtxrvh/image/upload/v1742413057/Untitled_design_1_hvuwau.png';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: Colors.blueGrey,
            child: ClipOval(
              child: Image.network(
                user.profileImageUrl ?? defaultImageUrl,
                width: 96, // 2 * radius para llenar el círculo
                height: 96, // 2 * radius para llenar el círculo
                fit: BoxFit.cover, // Ajusta la imagen para cubrir el círculo
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator();
                },
                errorBuilder: (context, error, stackTrace) => Text(
                  user.fullName.isNotEmpty ? user.fullName[0] : '?',
                  style: const TextStyle(fontSize: 32, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user.fullName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '@${user.username}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Member since $memberSince',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
          if (location.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              location,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white60, fontSize: 12),
            ),
          ],
          if (bio.isNotEmpty) ...[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                bio,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onEditProfile,
                child: const Text('Edit Profile'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: onVerifyAccount,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white70),
                ),
                child: const Text(
                  'Verify Account',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}