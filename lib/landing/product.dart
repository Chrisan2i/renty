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
          Product(),
        ]),
      ),
    );
  }
}

class Product extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1271,
          height: 2491, // Altura reducida en 90px (2581 - 90)
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 1272,
                  height: 2491,
                  decoration: BoxDecoration(color: const Color(0xFF111111)),
                ),
              ),
              Positioned(
                left: 72,
                top: 48, // Original: 138 - 90 = 48
                child: Container(
                  width: 1128,
                  height: 500,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF222222),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 72,
                top: 48,
                child: Container(
                  width: 1128,
                  height: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/1128x500"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 72,
                top: 596, // Original: 686 - 90 = 596
                child: Container(
                  width: 1128,
                  height: 394,
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
                left: 105,
                top: 629, // Original: 719 - 90 = 629
                child: Text(
                  'DeWalt Power Drill - Professional Grade',
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
                left: 105,
                top: 693, // Original: 783 - 90 = 693
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
                left: 129,
                top: 693,
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
                left: 161,
                top: 693,
                child: Text(
                  '(42 reviews)',
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
                left: 288,
                top: 693,
                child: Text(
                  'Brooklyn, NY',
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
                left: 420,
                top: 693,
                child: Text(
                  'Tools',
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
                left: 105,
                top: 744, // Original: 834 - 90 = 744
                child: SizedBox(
                  width: 984,
                  child: Text(
                    'Professional-grade power drill perfect for home improvement projects. Includes multiple drill bits and carrying case. Recently serviced and maintained.',
                    style: TextStyle(
                      color: const Color(0xFF999999),
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.56,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 105,
                top: 829, // Original: 919 - 90 = 829
                child: Text(
                  'Features',
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
                left: 105,
                top: 905, // Original: 995 - 90 = 905
                child: Text(
                  '\$25',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 164,
                top: 923, // Original: 1013 - 90 = 923
                child: Text(
                  '/day',
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
                left: 1029,
                top: 901, // Original: 991 - 90 = 901
                child: Container(
                  width: 137,
                  height: 56,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 1061,
                top: 917, // Original: 1007 - 90 = 917
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
                top: 1014, // Original: 1104 - 90 = 1014
                child: Container(
                  width: 1128,
                  height: 255,
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
                left: 105,
                top: 1047, // Original: 1137 - 90 = 1047
                child: Text(
                  'Customer Reviews',
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
                left: 113,
                top: 1091, // Original: 1181 - 90 = 1091
                child: Text(
                  '4.8 out of 5',
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
                left: 208,
                top: 1091,
                child: Text(
                  'Based on 42 reviews',
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
                left: 105,
                top: 1179, // Original: 1269 - 90 = 1179
                child: Container(
                  width: 1062,
                  height: 57,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withValues(alpha: 26),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 559,
                top: 1196, // Original: 1286 - 90 = 1196
                child: Text(
                  'Show More Reviews',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 72,
                top: 1317, // Original: 1407 - 90 = 1317
                child: Container(
                  width: 1128,
                  height: 402,
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
                left: 105,
                top: 1350, // Original: 1440 - 90 = 1350
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/80x80"),
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
                left: 201,
                top: 1358, // Original: 1448 - 90 = 1358
                child: Text(
                  'David Wilson',
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
                left: 201,
                top: 1398, // Original: 1488 - 90 = 1398
                child: Text(
                  'Member since 2021',
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
                left: 105,
                top: 1454, // Original: 1544 - 90 = 1454
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
                left: 129,
                top: 1454,
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
                left: 161,
                top: 1454,
                child: Text(
                  '(156 reviews)',
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
                left: 105,
                top: 1504, // Original: 1594 - 90 = 1504
                child: Container(
                  width: 20,
                  height: 20,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 133,
                top: 1502, // Original: 1592 - 90 = 1502
                child: Text(
                  'Usually responds within 1 hour',
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
                left: 105,
                top: 1544, // Original: 1634 - 90 = 1544
                child: Container(
                  width: 20,
                  height: 20,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 133,
                top: 1542, // Original: 1632 - 90 = 1542
                child: Text(
                  '98% rental completion rate',
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
                left: 105,
                top: 1584, // Original: 1674 - 90 = 1584
                child: Container(
                  width: 20,
                  height: 20,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 133,
                top: 1582, // Original: 1672 - 90 = 1582
                child: Text(
                  'Identity verified',
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
                left: 105,
                top: 1630, // Original: 1720 - 90 = 1630
                child: Container(
                  width: 1062,
                  height: 56,
                  decoration: ShapeDecoration(
                    color: const Color(0x190085FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 574,
                top: 1646, // Original: 1736 - 90 = 1646
                child: Text(
                  'Message Owner',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 72,
                top: 1743, // Original: 1833 - 90 = 1743
                child: Container(
                  width: 1128,
                  height: 310,
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
                left: 105,
                top: 1776, // Original: 1866 - 90 = 1776
                child: Text(
                  'Rental Details',
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
                left: 105,
                top: 1836, // Original: 1926 - 90 = 1836
                child: Text(
                  'Minimum rental period',
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
                left: 1128,
                top: 1836,
                child: Text(
                  '1 day',
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
                left: 105,
                top: 1876, // Original: 1966 - 90 = 1876
                child: Text(
                  'Maximum rental period',
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
                left: 1106,
                top: 1876,
                child: Text(
                  '30 days',
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
                left: 105,
                top: 1916, // Original: 2006 - 90 = 1916
                child: Text(
                  'Security deposit',
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
                left: 1130,
                top: 1916,
                child: Text(
                  '\$100',
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
                left: 105,
                top: 1956, // Original: 2046 - 90 = 1956
                child: Text(
                  'Insurance included',
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
                left: 1139,
                top: 1956,
                child: Text(
                  'Yes',
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
                left: 105,
                top: 1996, // Original: 2086 - 90 = 1996
                child: Text(
                  'Cancellation policy',
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
                left: 1109,
                top: 1996,
                child: Text(
                  'Flexible',
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
                top: 2077, // Original: 2167 - 90 = 2077
                child: Container(
                  width: 1128,
                  height: 366,
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
                left: 105,
                top: 2110, // Original: 2200 - 90 = 2110
                child: Text(
                  'Location',
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
                left: 105,
                top: 2170, // Original: 2260 - 90 = 2170
                child: Container(
                  width: 1062,
                  height: 200,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF333333),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 105,
                top: 2386, // Original: 2476 - 90 = 2386
                child: Text(
                  'Exact location provided after booking',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
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