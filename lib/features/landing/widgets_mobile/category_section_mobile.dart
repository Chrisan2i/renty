import 'package:flutter/material.dart';
import 'package:renty/core/constant/category.dart';
import 'package:renty/core/theme/app_colors.dart';
import 'package:renty/core/theme/text_styles.dart';
import 'package:renty/core/utils/app_layout.dart';
import 'package:renty/features/categories/models/category_model.dart';
import 'package:renty/features/categories/services/category_service.dart';

class CategorySectionMobile extends StatelessWidget {
  const CategorySectionMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.backgroundGrey
        : const Color(0xFFF6F6F6); // blanco-gris claro para diferenciar

    final header = Text(
      kCategorySectionTitle,
      textAlign: TextAlign.center,
      style: AppTextStyles.categoryHeader(context).copyWith(fontSize: 18),
    );

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: FutureBuilder<List<CategoryModel>>(
        future: CategoryService().getAllCategories(),
        builder: (context, snapshot) {
          Widget body;

          if (snapshot.hasError) {
            body = Text(
              'Error al cargar categorías',
              textAlign: TextAlign.center,
              style: AppTextStyles.categoryDesc(context).copyWith(color: Colors.red),
            );
          } else if (!snapshot.hasData) {
            body = const Center(child: CircularProgressIndicator());
          } else {
            final categories = snapshot.data!;
            body = Column(
              children: categories.map((cat) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  color: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: cat.iconUrl != null && cat.iconUrl!.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        cat.iconUrl!,
                        height: 48,
                        width: 48,
                        fit: BoxFit.cover,
                      ),
                    )
                        : null,
                    title: Text(
                      cat.name,
                      style: AppTextStyles.categoryTitle(context).copyWith(fontSize: 16),
                    ),
                    subtitle: Text(
                      cat.description,
                      style: AppTextStyles.categoryDesc(context).copyWith(fontSize: 12),
                    ),
                    trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
                    onTap: () {
                      Navigator.pushNamed(context, '/search', arguments: cat.slug);
                    },
                  ),
                );
              }).toList(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              header,
              const SizedBox(height: 20),
              body,
            ],
          );
        },
      ),
    );
  }
}
