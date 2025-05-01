import 'package:flutter/material.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          ProfileSettings(),
        ]),
      ),
    );
  }
}

class ProfileSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1271,
          height: 905,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 1272,
                  height: 905,
                  decoration: BoxDecoration(color: const Color(0xFF111111)),
                ),
              ),
              Positioned(
                left: 68,
                top: 138,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/120x120"),
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 3,
                        color: const Color(0xFF0085FF),
                      ),
                      borderRadius: BorderRadius.circular(16777200),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 212,
                top: 158,
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 212,
                top: 214,
                child: Text(
                  'Update your personal information',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 68,
                top: 306,
                child: Container(
                  width: 1136,
                  height: 551,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF222222),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withValues(alpha: 26),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 101,
                top: 339,
                child: Text(
                  'Full Name',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 101,
                top: 368,
                child: Container(
                  width: 523,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF111111),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withValues(alpha: 26),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 648,
                top: 339,
                child: Text(
                  'Email Address',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 648,
                top: 368,
                child: Container(
                  width: 523,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF111111),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withValues(alpha: 26),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 101,
                top: 442,
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 101,
                top: 471,
                child: Container(
                  width: 523,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF111111),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withValues(alpha: 26),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 648,
                top: 442,
                child: Text(
                  'Location',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 648,
                top: 471,
                child: Container(
                  width: 523,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF111111),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withValues(alpha: 26),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 101,
                top: 545,
                child: Text(
                  'Bio',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 101,
                top: 574,
                child: Container(
                  width: 1070,
                  height: 120,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF111111),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withValues(alpha: 26),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 101,
                top: 720,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF3399FF),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: const Color(0xFF666666),
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 133,
                top: 718,
                child: Text(
                  'Receive email notifications about new messages and updates',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 896,
                top: 774,
                child: Container(
                  width: 102,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF222222),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withValues(alpha: 26),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 921,
                top: 787,
                child: Text(
                  'Cancel',
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
                left: 1014,
                top: 774,
                child: Container(
                  width: 157,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 1038,
                top: 787,
                child: Text(
                  'Save Changes',
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