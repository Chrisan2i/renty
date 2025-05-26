import 'package:flutter/material.dart';

class MyRentalRequests extends StatelessWidget {
  const MyRentalRequests({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1271,
          height: 1662,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 1272,
                  height: 1662,
                  decoration: BoxDecoration(color: const Color(0xFF111111)),
                ),
              ),
              Positioned(
                left: 52,
                top: 24,
                child: Text(
                  'Rental Requests',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.43,
                  ),
                ),
              ),
              Positioned(
                left: 52,
                top: 72,
                child: Text(
                  'Manage requests from people who want to rent your products',
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
                left: 52,
                top: 120,
                child: Container(
                  width: 1168,
                  height: 36,
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
                left: 52,
                top: 120,
                child: Container(
                  width: 98,
                  height: 35,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFF0085FF),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 120,
                child: Text(
                  'All Requests',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 165,
                top: 120,
                child: Container(
                  width: 70,
                  height: 35,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: Colors.black.withValues(alpha: 0),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 173,
                top: 120,
                child: Text(
                  'Pending',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 251,
                top: 120,
                child: Container(
                  width: 80,
                  height: 35,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: Colors.black.withValues(alpha: 0),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 259,
                top: 120,
                child: Text(
                  'Accepted',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 347,
                top: 120,
                child: Container(
                  width: 74,
                  height: 35,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: Colors.black.withValues(alpha: 0),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 355,
                top: 120,
                child: Text(
                  'Rejected',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 52,
                top: 180,
                child: Container(
                  width: 1168,
                  height: 373,
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
                left: 69,
                top: 197,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/50x50"),
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFF0085FF),
                      ),
                      borderRadius: BorderRadius.circular(16777200),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 199,
                child: Text(
                  'Sarah Johnson',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.33,
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 227,
                child: Text(
                  '★',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 151,
                top: 227,
                child: Text(
                  '4.8',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 177,
                top: 227,
                child: Text(
                  '(23 reviews)',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1067,
                top: 197,
                child: Container(
                  width: 62,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0x1FF59E0B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 1075,
                top: 201,
                child: Text(
                  'Pending',
                  style: TextStyle(
                    color: const Color(0xFFF59E0B),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1137,
                top: 201,
                child: Text(
                  '2024-01-15',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 263,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/60x60"),
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 141,
                top: 263,
                child: Text(
                  'DeWalt Power Drill - Professional Grade',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.38,
                  ),
                ),
              ),
              Positioned(
                left: 141,
                top: 293,
                child: Text(
                  'Start:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 175,
                top: 293,
                child: Text(
                  '2024-01-20',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 676,
                top: 293,
                child: Text(
                  'End:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 705,
                top: 293,
                child: Text(
                  '2024-01-25',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 141,
                top: 319,
                child: Text(
                  'Duration:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 196,
                top: 319,
                child: Text(
                  '5 days',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 676,
                top: 319,
                child: Text(
                  'Total:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 711,
                top: 319,
                child: Text(
                  '\$125',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 349,
                child: Container(
                  width: 1134,
                  height: 71,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF333333),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 361,
                child: Text(
                  'Message from renter:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 390,
                child: Text(
                  'Hi! I need this drill for a home renovation project. I have experience with power tools and will take great care of it.',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 436,
                child: Container(
                  width: 1134,
                  height: 37,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 583,
                top: 444,
                child: Text(
                  'Accept Request',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 481,
                child: Container(
                  width: 1134,
                  height: 39,
                  decoration: ShapeDecoration(
                    color: const Color(0x19EF4444),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFEF4444),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 586,
                top: 490,
                child: Text(
                  'Reject Request',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFEF4444),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 52,
                top: 569,
                child: Container(
                  width: 1168,
                  height: 373,
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
                left: 69,
                top: 586,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/50x50"),
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFF0085FF),
                      ),
                      borderRadius: BorderRadius.circular(16777200),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 588,
                child: Text(
                  'Michael Chen',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.33,
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 616,
                child: Text(
                  '★',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 151,
                top: 616,
                child: Text(
                  '4.9',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 177,
                top: 616,
                child: Text(
                  '(45 reviews)',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1066,
                top: 586,
                child: Container(
                  width: 62,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0x1FF59E0B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 1074,
                top: 590,
                child: Text(
                  'Pending',
                  style: TextStyle(
                    color: const Color(0xFFF59E0B),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1137,
                top: 590,
                child: Text(
                  '2024-01-14',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 652,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/60x60"),
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 141,
                top: 652,
                child: Text(
                  'DeWalt Power Drill - Professional Grade',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.38,
                  ),
                ),
              ),
              Positioned(
                left: 141,
                top: 682,
                child: Text(
                  'Start:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 175,
                top: 682,
                child: Text(
                  '2024-01-18',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 676,
                top: 682,
                child: Text(
                  'End:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 705,
                top: 682,
                child: Text(
                  '2024-01-22',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 141,
                top: 708,
                child: Text(
                  'Duration:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 196,
                top: 708,
                child: Text(
                  '4 days',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 676,
                top: 708,
                child: Text(
                  'Total:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 711,
                top: 708,
                child: Text(
                  '\$100',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 738,
                child: Container(
                  width: 1134,
                  height: 71,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF333333),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 750,
                child: Text(
                  'Message from renter:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 779,
                child: Text(
                  'Hello! I need this for building a deck. I can provide references and have insurance coverage.',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 825,
                child: Container(
                  width: 1134,
                  height: 37,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 583,
                top: 833,
                child: Text(
                  'Accept Request',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 870,
                child: Container(
                  width: 1134,
                  height: 39,
                  decoration: ShapeDecoration(
                    color: const Color(0x19EF4444),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFEF4444),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 586,
                top: 879,
                child: Text(
                  'Reject Request',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFEF4444),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 52,
                top: 958,
                child: Container(
                  width: 1168,
                  height: 375,
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
                left: 69,
                top: 975,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/50x50"),
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFF0085FF),
                      ),
                      borderRadius: BorderRadius.circular(16777200),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 977,
                child: Text(
                  'Emily Rodriguez',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.33,
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 1005,
                child: Text(
                  '★',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 151,
                top: 1005,
                child: Text(
                  '4.7',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 176,
                top: 1005,
                child: Text(
                  '(12 reviews)',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1059,
                top: 975,
                child: Container(
                  width: 70,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0x1F10B981),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 1067,
                top: 979,
                child: Text(
                  'Accepted',
                  style: TextStyle(
                    color: const Color(0xFF10B981),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1137,
                top: 979,
                child: Text(
                  '2024-01-13',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 1041,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/60x60"),
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 141,
                top: 1041,
                child: Text(
                  'DeWalt Power Drill - Professional Grade',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.38,
                  ),
                ),
              ),
              Positioned(
                left: 141,
                top: 1071,
                child: Text(
                  'Start:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 175,
                top: 1071,
                child: Text(
                  '2024-01-16',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 676,
                top: 1071,
                child: Text(
                  'End:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 705,
                top: 1071,
                child: Text(
                  '2024-01-17',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 141,
                top: 1097,
                child: Text(
                  'Duration:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 196,
                top: 1097,
                child: Text(
                  '1 day',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 676,
                top: 1097,
                child: Text(
                  'Total:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 711,
                top: 1097,
                child: Text(
                  '\$25',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 1127,
                child: Container(
                  width: 1134,
                  height: 71,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF333333),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 1139,
                child: Text(
                  'Message from renter:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 1168,
                child: Text(
                  'Quick project, just need it for one day to hang some shelves. Very responsible renter!',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 1214,
                child: Container(
                  width: 1134,
                  height: 39,
                  decoration: ShapeDecoration(
                    color: const Color(0x1910B981),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF10B981),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 575,
                top: 1223,
                child: Text(
                  'Request Accepted',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF10B981),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 1261,
                child: Container(
                  width: 1134,
                  height: 39,
                  decoration: ShapeDecoration(
                    color: const Color(0x190085FF),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFF0085FF),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 582,
                top: 1270,
                child: Text(
                  'Message Renter',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 52,
                top: 1349,
                child: Container(
                  width: 1168,
                  height: 289,
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
                left: 69,
                top: 1366,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/50x50"),
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFF0085FF),
                      ),
                      borderRadius: BorderRadius.circular(16777200),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 1368,
                child: Text(
                  'David Thompson',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.33,
                  ),
                ),
              ),
              Positioned(
                left: 131,
                top: 1396,
                child: Text(
                  '★',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 151,
                top: 1396,
                child: Text(
                  '3.2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 177,
                top: 1396,
                child: Text(
                  '(8 reviews)',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1064,
                top: 1366,
                child: Container(
                  width: 65,
                  height: 26,
                  decoration: ShapeDecoration(
                    color: const Color(0x1FEF4444),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 1072,
                top: 1370,
                child: Text(
                  'Rejected',
                  style: TextStyle(
                    color: const Color(0xFFEF4444),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 1137,
                top: 1370,
                child: Text(
                  '2024-01-12',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 1432,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/60x60"),
                      fit: BoxFit.contain,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 141,
                top: 1432,
                child: Text(
                  'DeWalt Power Drill - Professional Grade',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.38,
                  ),
                ),
              ),
              Positioned(
                left: 141,
                top: 1462,
                child: Text(
                  'Start:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 175,
                top: 1462,
                child: Text(
                  '2024-01-15',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 676,
                top: 1462,
                child: Text(
                  'End:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 705,
                top: 1462,
                child: Text(
                  '2024-01-20',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 141,
                top: 1488,
                child: Text(
                  'Duration:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 196,
                top: 1488,
                child: Text(
                  '5 days',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 676,
                top: 1488,
                child: Text(
                  'Total:',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 711,
                top: 1488,
                child: Text(
                  '\$125',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 69,
                top: 1518,
                child: Container(
                  width: 1134,
                  height: 71,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF333333),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 1530,
                child: Text(
                  'Message from renter:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 1559,
                child: Text(
                  'Need this for a big construction project. Will pay extra if needed.',
                  style: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: 12,
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