import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'app_layout.dart';

class AppDecorations {
  // Paso de "How It Works"
  static BoxDecoration hiwStepBox(BuildContext context) => BoxDecoration(
    color: Theme.of(context).primaryColor,
    borderRadius: BorderRadius.circular(AppLayout.hiwStepBoxSize * 0.2),
  );

  // Etiqueta arriba del título en el hero
  static BoxDecoration heroBadgeBox(BuildContext context) => BoxDecoration(
    color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.accentBlue.withOpacity(0.1)
        : AppColors.accentBlue.withOpacity(0.15),
    borderRadius: BorderRadius.circular(AppLayout.heroBadgeRadius),
  );

  // Botón principal en el hero
  static BoxDecoration heroButtonBox(BuildContext context) => BoxDecoration(
    color: Theme.of(context).primaryColor,
    borderRadius: BorderRadius.circular(AppLayout.heroButtonRadius),
  );

  // Tarjeta de Testimonial
  static BoxDecoration testimonialCard(BuildContext context) => BoxDecoration(
    color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.testimonialCardBg
        : Colors.grey[100],
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.testimonialCardBorder
          : Colors.grey.withOpacity(0.2),
    ),
  );

  // Flecha circular de los testimonios
  static BoxDecoration testimonialArrowBox(BuildContext context) =>
      BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      );

  // Tarjeta de categoría
  static BoxDecoration categoryCard(BuildContext context) => BoxDecoration(
    color: Theme.of(context).brightness == Brightness.dark
        ? AppColors.categoryCardBg
        : Colors.grey[100],
    borderRadius: BorderRadius.circular(AppLayout.categoryCardRadius),
    border: Border.all(
      color: Theme.of(context).brightness == Brightness.dark
          ? AppColors.categoryCardBorder
          : Colors.grey.withOpacity(0.2),
    ),
  );
}
