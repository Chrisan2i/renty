import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // How It Works
  static TextStyle hiwHeader  = GoogleFonts.inter(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w700);
  static TextStyle hiwTitle   = GoogleFonts.inter(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700);
  static TextStyle hiwDesc    = GoogleFonts.inter(color: AppColors.neutralGray, fontSize: 16);
  static TextStyle hiwEmoji   = const TextStyle(fontSize: 30);

  // Testimonial
  static TextStyle testimonialHeader = GoogleFonts.inter(
    color: AppColors.white,
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );

  /// Nombre del usuario
  static TextStyle testimonialName = GoogleFonts.inter(
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  /// Rol / subtítulo
  static TextStyle testimonialRole = GoogleFonts.inter(
    color: AppColors.accentBlue,
    fontSize: 16,
  );

  /// Mensaje del testimonio
  static TextStyle testimonialMsg = GoogleFonts.inter(
    color: AppColors.white,
    fontSize: 20,
  );

  // CATEGORY
  /// “Popular Categories”
  static TextStyle categoryHeader = GoogleFonts.inter(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w700);
  /// Títulos de cada tarjeta
  static TextStyle categoryTitle  = GoogleFonts.inter(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700);
  /// Descripción de cada tarjeta
  static TextStyle categoryDesc   = GoogleFonts.inter(color: AppColors.neutralGray, fontSize: 16);
  /// Enlace/acción de cada tarjeta
  static TextStyle categoryAction = GoogleFonts.inter(color: AppColors.accentBlue, fontSize: 16, fontWeight: FontWeight.w600);



  // Hero
  static TextStyle heroBadge    = GoogleFonts.inter(color: AppColors.accentBlue, fontSize: 16, fontWeight: FontWeight.w600);
  static TextStyle heroTitle1   = GoogleFonts.inter(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w700, height: 1);
  static TextStyle heroTitle2   = GoogleFonts.inter(color: AppColors.accentBlue, fontSize: 48, fontWeight: FontWeight.w700, height: 1);
  static TextStyle heroButton   = GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700);
}
