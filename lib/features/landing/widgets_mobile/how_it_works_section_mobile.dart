import 'package:flutter/material.dart';
import 'package:renty/core/constant/how_it_works.dart';
import 'package:renty/core/theme/app_colors.dart';
import 'package:renty/core/theme/text_styles.dart';
import 'package:renty/core/utils/app_layout.dart';
import 'package:renty/core/utils/app_decorations.dart';

class HowItWorksSectionMobile extends StatelessWidget {
  const HowItWorksSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            kHowItWorksSectionTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.hiwHeader(context).copyWith(fontSize: 20),
          ),
          const SizedBox(height: 32),
          ...kHowItWorksSteps.map((step) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    alignment: Alignment.center,
                    decoration: AppDecorations.hiwStepBox(context),
                    child: Text(
                      step['emoji']!,
                      style: AppTextStyles.hiwEmoji(context).copyWith(fontSize: 28),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    step['title']!,
                    style: AppTextStyles.hiwTitle(context).copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      step['desc']!,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.hiwDesc(context).copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
