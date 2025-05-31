import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // How It Works
  static TextStyle hiwHeader(BuildContext context) =>
      GoogleFonts.inter(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 36, fontWeight: FontWeight.w700);

  static TextStyle hiwTitle(BuildContext context) =>
      GoogleFonts.inter(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 24, fontWeight: FontWeight.w700);

  static TextStyle hiwDesc(BuildContext context) =>
      GoogleFonts.inter(color: AppColors.neutralGray, fontSize: 16);

  static TextStyle hiwEmoji(BuildContext context) =>
      const TextStyle(fontSize: 30);

  // Testimonial
  static TextStyle testimonialHeader(BuildContext context) =>
      GoogleFonts.inter(
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontSize: 36,
        fontWeight: FontWeight.w700,
      );

  static TextStyle testimonialName(BuildContext context) =>
      GoogleFonts.inter(
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );

  static TextStyle testimonialRole(BuildContext context) =>
      GoogleFonts.inter(
        color: AppColors.accentBlue,
        fontSize: 16,
      );

  static TextStyle testimonialMsg(BuildContext context) =>
      GoogleFonts.inter(
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontSize: 20,
      );

  // CATEGORY
  static TextStyle categoryHeader(BuildContext context) =>
      GoogleFonts.inter(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 36, fontWeight: FontWeight.w700);

  static TextStyle categoryTitle(BuildContext context) =>
      GoogleFonts.inter(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 24, fontWeight: FontWeight.w700);

  static TextStyle categoryDesc(BuildContext context) =>
      GoogleFonts.inter(color: AppColors.neutralGray, fontSize: 16);

  static TextStyle categoryAction(BuildContext context) =>
      GoogleFonts.inter(color: AppColors.accentBlue, fontSize: 16, fontWeight: FontWeight.w600);

  // Hero
  static TextStyle heroBadge(BuildContext context) =>
      GoogleFonts.inter(color: AppColors.accentBlue, fontSize: 16, fontWeight: FontWeight.w600);

  static TextStyle heroTitle1(BuildContext context) =>
      GoogleFonts.inter(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 48, fontWeight: FontWeight.w700, height: 1);

  static TextStyle heroTitle2(BuildContext context) =>
      GoogleFonts.inter(color: AppColors.accentBlue, fontSize: 48, fontWeight: FontWeight.w700, height: 1);

  static TextStyle heroButton(BuildContext context) =>
      GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700);
}
