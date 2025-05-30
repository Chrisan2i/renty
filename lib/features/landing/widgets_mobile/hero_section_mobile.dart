import 'package:flutter/material.dart';
import 'package:renty/core/constant/hero.dart';
import 'package:renty/core/theme/app_colors.dart';
import 'package:renty/core/theme/text_styles.dart';
import 'package:renty/core/utils/app_layout.dart';
import 'package:renty/core/utils/app_decorations.dart';

class HeroSectionMobile extends StatelessWidget {
  const HeroSectionMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: AppLayout.heroBadgePadding,
            decoration: AppDecorations.heroBadgeBox,
            child: Text(kHeroBadgeText, style: AppTextStyles.heroBadge.copyWith(fontSize: 12)),
          ),
          const SizedBox(height: 24),
          Text(
            kHeroTitleLine1,
            textAlign: TextAlign.center,
            style: AppTextStyles.heroTitle1.copyWith(fontSize: 24),
          ),
          Text(
            kHeroTitleLine2,
            textAlign: TextAlign.center,
            style: AppTextStyles.heroTitle2.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/search');
            },
            child: Container(
              padding: AppLayout.heroButtonPadding,
              decoration: AppDecorations.heroButtonBox,
              child: Text(kHeroButtonText, style: AppTextStyles.heroButton.copyWith(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
