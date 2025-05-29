import 'package:flutter/material.dart';
// Usa package imports o relativos SIN la barra inicial:
import 'package:renty/core/constant/hero.dart';
import 'package:renty/core/theme/app_colors.dart';
import 'package:renty/core/theme/text_styles.dart';
import 'package:renty/core/utils/app_layout.dart';
import 'package:renty/core/utils/app_decorations.dart';

import 'package:renty/features/search/view/search_page.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // aquí ya no falla:
      padding: EdgeInsets.symmetric(
        horizontal: AppLayout.sectionHorizontal / 2,
        vertical:   AppLayout.sectionVertical   * 0.8333,
      ),
      child: Column(
        children: [
          Container(
            padding: AppLayout.heroBadgePadding,
            decoration: AppDecorations.heroBadgeBox,
            child: Text(kHeroBadgeText, style: AppTextStyles.heroBadge),
          ),
          const SizedBox(height: AppLayout.spacingL),
          Text(kHeroTitleLine1, style: AppTextStyles.heroTitle1),
          Text(kHeroTitleLine2, style: AppTextStyles.heroTitle2),
          const SizedBox(height: AppLayout.spacingL),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/search');
            },
            child: Container(
              padding: AppLayout.heroButtonPadding,
              decoration: AppDecorations.heroButtonBox,
              child: Text(kHeroButtonText, style: AppTextStyles.heroButton),
            ),
          ),
        ],
      ),
    );
  }
}
