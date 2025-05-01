import 'package:flutter/material.dart';
import 'product_page.dart';

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
          Search(),
        ]),
      ),
    );
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1271,
          height: 892, // Reduje la altura total eliminando el espacio de la barra
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 1272,
                  height: 892, // Ajusté la altura
                  decoration: BoxDecoration(color: const Color(0xFF111111)),
                ),
              ),
              Positioned(
                left: 72,
                top: 48, // Ajusté la posición vertical (original: 147)
                child: Container(
                  width: 1016,
                  height: 58,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF222222),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withValues(alpha: 26),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 1047,
                top: 65, // Ajusté la posición vertical (original: 164)
                child: Text(
                  '🔍',
                  textAlign: TextAlign.center,
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
                left: 1103,
                top: 48, // Ajusté la posición vertical (original: 147)
                child: Container(
                  width: 96,
                  height: 58,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF222222),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withValues(alpha: 26),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 1128,
                top: 65, // Ajusté la posición vertical (original: 164)
                child: Text(
                  'Filters',
                  textAlign: TextAlign.center,
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
                left: 72,
                top: 154, // Ajusté la posición vertical (original: 253)
                child: Container(
                  width: 360,
                  height: 357,
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
                left: 73,
                top: 155, // Ajusté la posición vertical (original: 254)
                child: Container(
                  width: 358,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/358x200"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 97,
                top: 379, // Ajusté la posición vertical (original: 478)
                child: Text(
                  'Power Drill',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 97,
                top: 409, // Ajusté la posición vertical (original: 508)
                child: Text(
                  'Brooklyn, NY',
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
                left: 363,
                top: 379, // Ajusté la posición vertical (original: 478)
                child: Text(
                  '★',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 383,
                top: 379, // Ajusté la posición vertical (original: 478)
                child: Text(
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
                left: 97,
                top: 448, // Ajusté la posición vertical (original: 547)
                child: Text(
                  '\$25/day',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 302,
                top: 446, // Ajusté la posición vertical (original: 545)
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProductPage()),
                    );
                  },
                  child: Container(
                    width: 105,
                    height: 40,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF0085FF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 320,
                top: 450, // Ajusté la posición vertical (original: 553)
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProductPage()),
                    );
                  },
                  child: Text(
                    'Rent Now',
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
              ),
              Positioned(
                left: 456,
                top: 154, // Ajusté la posición vertical (original: 253)
                child: Container(
                  width: 360,
                  height: 357,
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
                left: 457,
                top: 155, // Ajusté la posición vertical (original: 254)
                child: Container(
                  width: 358,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/358x200"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 481,
                top: 379, // Ajusté la posición vertical (original: 478)
                child: Text(
                  'Mountain Bike',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 481,
                top: 409, // Ajusté la posición vertical (original: 508)
                child: Text(
                  'Manhattan, NY',
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
                left: 747,
                top: 379, // Ajusté la posición vertical (original: 478)
                child: Text(
                  '★',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 767,
                top: 379, // Ajusté la posición vertical (original: 478)
                child: Text(
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
                left: 481,
                top: 448, // Ajusté la posición vertical (original: 547)
                child: Text(
                  '\$45/day',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 686,
                top: 446, // Ajusté la posición vertical (original: 545)
                child: Container(
                  width: 105,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 702,
                top: 454, // Ajusté la posición vertical (original: 553)
                child: Text(
                  'Rent Now',
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
                left: 840,
                top: 154, // Ajusté la posición vertical (original: 253)
                child: Container(
                  width: 360,
                  height: 357,
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
                left: 841,
                top: 155, // Ajusté la posición vertical (original: 254)
                child: Container(
                  width: 358,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/358x200"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 865,
                top: 379, // Ajusté la posición vertical (original: 478)
                child: Text(
                  'Moving Van',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 865,
                top: 409, // Ajusté la posición vertical (original: 508)
                child: Text(
                  'Queens, NY',
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
                left: 1132,
                top: 379, // Ajusté la posición vertical (original: 478)
                child: Text(
                  '★',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1152,
                top: 379, // Ajusté la posición vertical (original: 478)
                child: Text(
                  '4.7',
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
                left: 865,
                top: 448, // Ajusté la posición vertical (original: 547)
                child: Text(
                  '\$89/day',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1070,
                top: 446, // Ajusté la posición vertical (original: 545)
                child: Container(
                  width: 105,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 1086,
                top: 454, // Ajusté la posición vertical (original: 553)
                child: Text(
                  'Rent Now',
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
                left: 72,
                top: 535, // Ajusté la posición vertical (original: 634)
                child: Container(
                  width: 360,
                  height: 357,
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
                left: 73,
                top: 536, // Ajusté la posición vertical (original: 635)
                child: Container(
                  width: 358,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/358x200"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 97,
                top: 760, // Ajusté la posición vertical (original: 859)
                child: Text(
                  'DSLR Camera',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 97,
                top: 790, // Ajusté la posición vertical (original: 889)
                child: Text(
                  'Staten Island, NY',
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
                left: 363,
                top: 760, // Ajusté la posición vertical (original: 859)
                child: Text(
                  '★',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 383,
                top: 760, // Ajusté la posición vertical (original: 859)
                child: Text(
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
                left: 97,
                top: 829, // Ajusté la posición vertical (original: 928)
                child: Text(
                  '\$55/day',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 302,
                top: 827, // Ajusté la posición vertical (original: 926)
                child: Container(
                  width: 105,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 318,
                top: 835, // Ajusté la posición vertical (original: 934)
                child: Text(
                  'Rent Now',
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
                left: 456,
                top: 535, // Ajusté la posición vertical (original: 634)
                child: Container(
                  width: 360,
                  height: 357,
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
                left: 457,
                top: 536, // Ajusté la posición vertical (original: 635)
                child: Container(
                  width: 358,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/358x200"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 481,
                top: 760, // Ajusté la posición vertical (original: 859)
                child: Text(
                  'Lawn Mower',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 481,
                top: 790, // Ajusté la posición vertical (original: 889)
                child: Text(
                  'Bronx, NY',
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
                left: 747,
                top: 760, // Ajusté la posición vertical (original: 859)
                child: Text(
                  '★',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 767,
                top: 760, // Ajusté la posición vertical (original: 859)
                child: Text(
                  '4.6',
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
                left: 481,
                top: 829, // Ajusté la posición vertical (original: 928)
                child: Text(
                  '\$35/day',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 686,
                top: 827, // Ajusté la posición vertical (original: 926)
                child: Container(
                  width: 105,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 702,
                top: 835, // Ajusté la posición vertical (original: 934)
                child: Text(
                  'Rent Now',
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
                left: 96,
                top: 64, // Ajusté la posición vertical (original: 163)
                child: Text(
                  'Search for anything to rent...',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
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