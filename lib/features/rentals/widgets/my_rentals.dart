import 'package:flutter/material.dart';




class MyRentals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1271,
          height: 965,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 1272,
                  height: 965,
                  decoration: BoxDecoration(color: const Color(0xFF111111)),
                ),
              ),
              Positioned(
                left: 88,
                top: 138,
                child: Container(
                  width: 1096,
                  height: 774,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF222222),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withAlpha(26),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 121,
                top: 171,
                child: Text(
                  'My Rentals',
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
                left: 969,
                top: 177,
                child: Container(
                  width: 89,
                  height: 37,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 993,
                top: 185,
                child: Text(
                  'Active',
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
                left: 1074,
                top: 177,
                child: Container(
                  width: 77,
                  height: 37,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF333333),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 1098,
                top: 185,
                child: Text(
                  'Past',
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
              // Primer alquiler
              Positioned(
                left: 121,
                top: 251,
                child: Container(
                  width: 1030,
                  height: 306,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF333333),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 145,
                top: 275,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/120x120"),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
                left: 289,
                top: 275,
                child: Text(
                  'DeWalt Power Drill - Professional Grade',
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
                left: 289,
                top: 319,
                child: Row(
                  children: [
                    Text(
                      '★',
                      style: TextStyle(
                        color: const Color(0xFF0085FF),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '(42 reviews)',
                      style: TextStyle(
                        color: const Color(0xFF999999),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 289,
                top: 351,
                child: Text(
                  'Rental ID: RNT-2024011534',
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
                left: 1053,
                top: 275,
                child: Container(
                  width: 73,
                  height: 37,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0085FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
              ),
              Positioned(
                left: 1069,
                top: 283,
                child: Text(
                  'Active',
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
                left: 289,
                top: 399,
                child: Text(
                  'Start Date',
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
                left: 289,
                top: 423,
                child: Text(
                  'Jan 15, 2024 09:00 AM',
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
                left: 513,
                top: 399,
                child: Text(
                  'End Date',
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
                left: 513,
                top: 423,
                child: Text(
                  'Jan 17, 2024 09:00 AM',
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
                left: 734,
                top: 399,
                child: Text(
                  'Time Remaining',
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
                left: 734,
                top: 423,
                child: Text(
                  '1d 23h 45m',
                  style: TextStyle(
                    color: const Color(0xFF0085FF),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                  ),
                ),
              ),
              // Botón Extender
              Positioned(
                left: 289,
                top: 483,
                child: Container(
                  width: 838,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0x190085FF),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: const Color(0xFF0085FF)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 656,
                top: 496,
                child: Text(
                  'Extend Rental',
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
              // Aquí podrías seguir con el segundo ítem de alquiler (Pressure Washer), usando el mismo patrón
            ],
          ),
        ),
      ],
    );
  }
}
