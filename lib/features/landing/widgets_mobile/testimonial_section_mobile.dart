// lib/features/home/widgets/testimonial_section_mobile.dart

import 'package:flutter/material.dart';
import 'package:renty/core/constant/testimonial.dart';
import 'package:renty/core/theme/app_colors.dart';
import 'package:renty/core/theme/text_styles.dart';
import 'package:renty/core/utils/app_layout.dart';
import 'package:renty/core/utils/app_decorations.dart';

class TestimonialSectionMobile extends StatelessWidget {
  const TestimonialSectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundGrey,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            kTestimonialSectionTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.testimonialHeader.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: AppDecorations.testimonialCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(kTestimonialAvatarUrl),
                ),
                const SizedBox(height: 16),
                Text(kTestimonialName, style: AppTextStyles.testimonialName.copyWith(fontSize: 14)),
                Text(kTestimonialRole, style: AppTextStyles.testimonialRole.copyWith(fontSize: 12)),
                const SizedBox(height: 12),
                Text(
                  kTestimonialMessage,
                  style: AppTextStyles.testimonialMsg.copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  width: 36,
                  height: 36,
                  decoration: AppDecorations.testimonialArrowBox,
                  child: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
