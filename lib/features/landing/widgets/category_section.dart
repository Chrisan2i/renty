import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renty/core/constant/category.dart';
import 'package:renty/core/theme/app_colors.dart';
import 'package:renty/core/theme/text_styles.dart';
import 'package:renty/core/utils/app_layout.dart';
import 'package:renty/core/utils/app_decorations.dart';
import 'package:renty/features/categories/models/category_model.dart';
import 'package:renty/features/categories/services/category_service.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.backgroundGrey // gris oscuro original
        : const Color(0xFFF6F6F6); // gris muy claro, no blanco puro

    final header = Text(
      kCategorySectionTitle,
      textAlign: TextAlign.center,
      style: AppTextStyles.categoryHeader(context),
    );

    return Container(
      color: backgroundColor,
      padding: AppLayout.sectionPadding,
      child: FutureBuilder<List<CategoryModel>>(
        future: CategoryService().getAllCategories(),
        builder: (context, snapshot) {
          Widget body;

          if (snapshot.hasError) {
            body = Text(
              'Error loading categories',
              textAlign: TextAlign.center,
              style: AppTextStyles.categoryDesc(context).copyWith(color: Colors.red),
            );
          } else if (!snapshot.hasData) {
            body = const Center(child: CircularProgressIndicator());
          } else {
            final categories = snapshot.data!;
            body = Wrap(
              spacing: AppLayout.spacingM,
              runSpacing: AppLayout.spacingM,
              alignment: WrapAlignment.center,
              children: categories.map((cat) {
                return Container(
                  width: AppLayout.categoryCardWidth,
                  padding: EdgeInsets.all(AppLayout.categoryCardPadding),
                  decoration: AppDecorations.categoryCard(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Text(cat.name, style: AppTextStyles.categoryTitle(context)),
                      const SizedBox(height: AppLayout.spacingS),
                      Text(cat.description, style: AppTextStyles.categoryDesc(context)),
                      const SizedBox(height: AppLayout.spacingS),
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
                          style: AppTextStyles.categoryAction(context),
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

