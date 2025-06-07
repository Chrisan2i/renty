import 'package:flutter/material.dart';
import 'package:renty/features/products/models/product_model.dart';
import 'product_card.dart'; // Asegúrate de importar correctamente

class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  final String? title;

  const ProductGrid({
    Key? key,
    required this.products,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 1;
            double width = constraints.maxWidth;

            if (width >= 1200) {
              crossAxisCount = 4;
            } else if (width >= 900) {
              crossAxisCount = 3;
            } else if (width >= 600) {
              crossAxisCount = 2;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.68,
              ),
              itemBuilder: (context, i) =>
                  ProductCard(product: products[i]),
            );
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
