import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'app_layout.dart';

class AppDecorations {
  static final BoxDecoration hiwStepBox = BoxDecoration(
    color: AppColors.accentBlue,
    borderRadius: BorderRadius.circular(AppLayout.hiwStepBoxSize * 0.2), // 20
  );
  static final BoxDecoration heroBadgeBox = BoxDecoration(
    color: AppColors.accentBlue.withOpacity(0.1), // 0x19 = 10% opacity
    borderRadius: BorderRadius.circular(AppLayout.heroBadgeRadius),
  );
  static final BoxDecoration heroButtonBox = BoxDecoration(
    color: AppColors.accentBlue,
    borderRadius: BorderRadius.circular(AppLayout.heroButtonRadius),
  );

  /// Decoración de la tarjeta testimonial
  static BoxDecoration testimonialCard = BoxDecoration(
    color: AppColors.testimonialCardBg,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppColors.testimonialCardBorder),
  );

  /// Decoración del botón de flecha
  static BoxDecoration testimonialArrowBox = const BoxDecoration(
    color: AppColors.accentBlue,
    shape: BoxShape.circle,
  );
  /// Carta de Category
  static BoxDecoration categoryCard = BoxDecoration(
    color: AppColors.categoryCardBg,
    borderRadius: BorderRadius.circular(AppLayout.categoryCardRadius),
    border: Border.all(color: AppColors.categoryCardBorder),
  );
}
