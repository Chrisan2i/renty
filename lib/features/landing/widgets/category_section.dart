// lib/features/landing/widgets/category_section.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renty/core/constant/category.dart';
import 'package:renty/core/theme/app_colors.dart';
import 'package:renty/core/theme/text_styles.dart';
import 'package:renty/core/utils/app_layout.dart';
import 'package:renty/core/utils/app_decorations.dart';
import 'package:renty/features/categories/models/category_model.dart';
import 'package:renty/features/categories/services/category_service.dart';

/// Displays the “Popular Categories” section on the landing page.
///
/// - Loads categories from Firestore via [CategoryService].
/// - Shows a loader while fetching, or an error message if it fails.
/// - Renders each category with its name, description, optional image,
///   and a tappable “Browse Category →” that navigates to `/search`.
/// - Design, paddings, fonts and colors match the original static version exactly.
class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Section title, identical to original design
    final header = Text(
      kCategorySectionTitle,
      textAlign: TextAlign.center,
      style: AppTextStyles.categoryHeader,
    );

    return Container(
      color: AppColors.backgroundGrey,
      padding: AppLayout.sectionPadding,
      child: FutureBuilder<List<CategoryModel>>(
        future: CategoryService().getAllCategories(),
        builder: (context, snapshot) {
          Widget body;

          if (snapshot.hasError) {
            // Error state
            body = Text(
              'Error loading categories',
              textAlign: TextAlign.center,
              style: AppTextStyles.categoryDesc.copyWith(color: Colors.red),
            );
          } else if (!snapshot.hasData) {
            // Loading state
            body = const Center(child: CircularProgressIndicator());
          } else {
            // Data loaded successfully
            final categories = snapshot.data!;
            body = Wrap(
              spacing: AppLayout.spacingM,
              runSpacing: AppLayout.spacingM,
              alignment: WrapAlignment.center,
              children: categories.map((cat) {
                return Container(
                  width: AppLayout.categoryCardWidth,
                  padding: EdgeInsets.all(AppLayout.categoryCardPadding),
                  decoration: AppDecorations.categoryCard,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Optional image at top of card
                      if (cat.iconUrl != null && cat.iconUrl!.isNotEmpty) ...[
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(cat.iconUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppLayout.spacingS),
                      ],
                      // Category title
                      Text(cat.name, style: AppTextStyles.categoryTitle),
                      const SizedBox(height: AppLayout.spacingS),
                      // Category description
                      Text(cat.description, style: AppTextStyles.categoryDesc),
                      const SizedBox(height: AppLayout.spacingS),
                      // Browse link
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/search',
                            arguments: cat.slug,
                          );
                        },
                        child: Text(
                          kCategoryActionText,
                          style: AppTextStyles.categoryAction,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              header,
              const SizedBox(height: AppLayout.spacingL),
              body,
            ],
          );
        },
      ),
    );
  }
}
