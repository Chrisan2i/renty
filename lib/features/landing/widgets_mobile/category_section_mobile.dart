
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
    final header = Text(
      kCategorySectionTitle,
      textAlign: TextAlign.center,
      style: AppTextStyles.categoryHeader.copyWith(fontSize: 18),
    );

    return Container(
      color: AppColors.backgroundGrey,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: FutureBuilder<List<CategoryModel>>(
        future: CategoryService().getAllCategories(),
        builder: (context, snapshot) {
          Widget body;

          if (snapshot.hasError) {
            body = Text(
              'Error al cargar categorías',
              textAlign: TextAlign.center,
              style: AppTextStyles.categoryDesc.copyWith(color: Colors.red),
            );
          } else if (!snapshot.hasData) {
            body = const Center(child: CircularProgressIndicator());
          } else {
            final categories = snapshot.data!;
            body = Column(
              children: categories.map((cat) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: cat.iconUrl != null && cat.iconUrl!.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(cat.iconUrl!, height: 48, width: 48, fit: BoxFit.cover),
                    )
                        : null,
                    title: Text(cat.name, style: AppTextStyles.categoryTitle.copyWith(fontSize: 16)),
                    subtitle: Text(cat.description, style: AppTextStyles.categoryDesc.copyWith(fontSize: 12)),
                    trailing: const Icon(Icons.chevron_right),
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