import 'package:flutter/widgets.dart';

class AppLayout {

  // en lugar de solo un EdgeInsets,
  // definimos las dos medidas por separado:
  static const double sectionHorizontal = 32;
  static const double sectionVertical   = 48;

  // y luego creamos el padding completo:
  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(
    horizontal: sectionHorizontal,
    vertical: sectionVertical,
  );

  // resto de constantes:
  static const double spacingXL          = 48;
  static const double spacingL           = 32;
  static const double spacingM           = 16;
  static const double spacingS           = 8;
  static const double hiwStepBoxSize     = 100;
  static const double hiwDescWidth       = 300;
  static const double categoryCardWidth  = 200;
  static const double categoryCardPadding = 16;
  static const double categoryCardRadius = 20;
  static const double heroBadgeRadius    = 999;
  static const double heroButtonRadius   = 8;
  /// Padding interno de la tarjeta testimonial
  static const EdgeInsets testimonialCardPadding = EdgeInsets.all(spacingM);
  /// Radio del avatar
  static const double avatarRadius = 40;

  /// Ancho fijo de la tarjeta
  static const double testimonialCardWidth = 900;

  /// Tamaño del botón flecha
  static const double arrowButtonSize = 50;

  static const EdgeInsets heroBadgePadding  = EdgeInsets.symmetric(horizontal: 20, vertical: 8);
  static const EdgeInsets heroButtonPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 8);
}
