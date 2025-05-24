import 'package:flutter/material.dart';
import '/../core/constant/how_it_works.dart';
import '/../core/theme/app_colors.dart';
import '/../core/theme/text_styles.dart';
import '/../core/utils/app_layout.dart';
import '/../core/utils/app_decorations.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundDark,
      padding: AppLayout.sectionPadding,
      child: Column(
        children: [
          Text(kHowItWorksSectionTitle, style: AppTextStyles.hiwHeader),
          const SizedBox(height: AppLayout.spacingL),
          Wrap(
            spacing: AppLayout.spacingXL,
            runSpacing: AppLayout.spacingXL,
            alignment: WrapAlignment.center,
            children: kHowItWorksSteps.map((step) {
              return Column(
                children: [
                  Container(
                    width: AppLayout.hiwStepBoxSize,
                    height: AppLayout.hiwStepBoxSize,
                    alignment: Alignment.center,
                    decoration: AppDecorations.hiwStepBox,
                    child: Text(step['emoji']!, style: AppTextStyles.hiwEmoji),
                  ),
                  const SizedBox(height: AppLayout.spacingM),
                  Text(step['title']!, style: AppTextStyles.hiwTitle),
                  const SizedBox(height: AppLayout.spacingS),
                  SizedBox(
                    width: AppLayout.hiwDescWidth,
                    child: Text(
                      step['desc']!,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.hiwDesc,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
