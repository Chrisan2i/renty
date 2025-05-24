// lib/features/home/widgets/testimonial_section.dart

import 'package:flutter/material.dart';
import 'package:renty/core/constant/testimonial.dart';
import 'package:renty/core/theme/app_colors.dart';
import 'package:renty/core/theme/text_styles.dart';
import 'package:renty/core/utils/app_layout.dart';
import 'package:renty/core/utils/app_decorations.dart';

class TestimonialSection extends StatelessWidget {
  const TestimonialSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundGrey,
      padding: AppLayout.sectionPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            kTestimonialSectionTitle,
            style: AppTextStyles.testimonialHeader,
          ),
          const SizedBox(height: AppLayout.spacingL),
          Center(
            child: Container(
              width: AppLayout.testimonialCardWidth,
              padding: AppLayout.testimonialCardPadding,
              decoration: AppDecorations.testimonialCard,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: AppLayout.avatarRadius,
                    backgroundImage: NetworkImage(kTestimonialAvatarUrl),
                  ),
                  const SizedBox(width: AppLayout.spacingL),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(kTestimonialName, style: AppTextStyles.testimonialName),
                        Text(kTestimonialRole, style: AppTextStyles.testimonialRole),
                        const SizedBox(height: AppLayout.spacingS),
                        Text(kTestimonialMessage, style: AppTextStyles.testimonialMsg),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppLayout.spacingS),
                  Container(
                    width: AppLayout.arrowButtonSize,
                    height: AppLayout.arrowButtonSize,
                    alignment: Alignment.center,
                    decoration: AppDecorations.testimonialArrowBox,
                    child: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

