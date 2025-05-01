import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfile extends StatelessWidget {
  final User user;
  const MyProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final displayName = user.displayName ?? user.email?.split('@').first ?? 'User';
    final userPhoto = user.photoURL;

    return Column(
      children: [
        Container(
          width: 1271,
          height: 1311,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 1272,
                  height: 1311,
                  decoration: BoxDecoration(color: const Color(0xFF111111)),
                ),
              ),
              Positioned(
                left: 32,
                top: 123,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: userPhoto != null
                          ? NetworkImage(userPhoto)
                          : const NetworkImage("https://placehold.co/120x120"),
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 3,
                        color: Color(0xFF0085FF),
                      ),
                      borderRadius: BorderRadius.circular(16777200),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 176,
                top: 123,
                child: Text(
                  displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 176,
                top: 179,
                child: const Text(
                  '★',
                  style: TextStyle(
                    color: Color(0xFF0085FF),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 200,
                top: 179,
                child: const Text(
                  '4.9',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 232,
                top: 179,
                child: const Text(
                  '(124 reviews)',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 341,
                top: 179,
                child: const Text(
                  'Member since March 2022',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 176,
                top: 211,
                child: const Text(
                  'San Francisco, CA',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 176,
                top: 243,
                child: const Text(
                  'Passionate about sharing useful tools and equipment with my community',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 176,
                top: 291,
                child: Container(
                  width: 130,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 200,
                top: 304,
                child: const Text(
                  'Edit Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 318,
                top: 291,
                child: Container(
                  width: 162,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF222222),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withOpacity(0.26),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 343,
                top: 304,
                child: const Text(
                  'Verify Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 373,
                child: Container(
                  width: 1208,
                  height: 57,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withOpacity(0.26),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 389,
                child: const Text(
                  'My Listings (2)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0085FF),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 168,
                top: 389,
                child: const Text(
                  'Reviews (124)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 462,
                child: Container(
                  width: 1208,
                  height: 382,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF222222),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withOpacity(0.26),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 463,
                child: Container(
                  width: 1206,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/1206x200"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 57,
                top: 687,
                child: const Text(
                  'Professional DSLR Camera',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 57,
                top: 731,
                child: const Text(
                  '★',
                  style: TextStyle(
                    color: Color(0xFF0085FF),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 731,
                child: const Text(
                  '4.9',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 113,
                top: 731,
                child: const Text(
                  '(32 reviews)',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1128,
                top: 687,
                child: const Text(
                  '\$45',
                  style: TextStyle(
                    color: Color(0xFF0085FF),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1181,
                top: 693,
                child: const Text(
                  '/day',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 57,
                top: 783,
                child: const Text(
                  'active',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1084,
                top: 771,
                child: Container(
                  width: 131,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 1108,
                top: 783,
                child: const Text(
                  'Edit Listing',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 32,
                top: 868,
                child: Container(
                  width: 1208,
                  height: 382,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF222222),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withOpacity(0.26),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 869,
                child: Container(
                  width: 1206,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/1206x200"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 57,
                top: 1093,
                child: const Text(
                  'Electric Power Drill',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 57,
                top: 1137,
                child: const Text(
                  '★',
                  style: TextStyle(
                    color: Color(0xFF0085FF),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 1137,
                child: const Text(
                  '4.8',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 113,
                top: 1137,
                child: const Text(
                  '(18 reviews)',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1129,
                top: 1093,
                child: const Text(
                  '\$25',
                  style: TextStyle(
                    color: Color(0xFF0085FF),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1181,
                top: 1099,
                child: const Text(
                  '/day',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 57,
                top: 1189,
                child: const Text(
                  'completed',
                  style: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1084,
                top: 1177,
                child: Container(
                  width: 131,
                  height: 48,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 1108,
                top: 1189,
                child: const Text(
                  'Edit Listing',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}