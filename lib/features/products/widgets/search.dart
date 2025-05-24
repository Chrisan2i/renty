import 'package:flutter/material.dart';
import 'package:renty/features/products/models/product_model.dart';
import 'package:renty/features/products/services/product_service.dart';
import 'package:renty/features/products/widgets/product_card.dart';
// Nuevos imports para manejar categorías
import 'package:renty/features/categories/models/category_model.dart';
import 'package:renty/features/categories/services/category_service.dart';

class Search extends StatefulWidget {
  final List<String> initialSelectedCategories;

  const Search({
    Key? key,
    this.initialSelectedCategories = const [],
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _searchQuery = '';
  late List<String> _selectedCategories;

  @override
  void initState() {
    super.initState();
    _selectedCategories = List.of(widget.initialSelectedCategories);
  }

  // Helper para convertir cualquier cadena a un slug consistente
  String _slugify(String input) {
    return input
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w]+'), '-')   // no alfanum → guión
        .replaceAll(RegExp(r'(^-+|-+$)'), ''); // quita guiones inicio/final
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ─── Barra de búsqueda ─────────────────────────────────────────
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFF222222),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (v) => setState(() => _searchQuery = v),
                        decoration: InputDecoration(
                          hintText: 'Search for anything to rent...',
                          hintStyle:
                          const TextStyle(color: Color(0xFF888888)),
                          prefixIcon: const Icon(Icons.search,
                              color: Color(0xFF888888)),
                          filled: true,
                          fillColor: const Color(0xFF333333),
                          contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    StreamBuilder<List<ProductModel>>(
                      stream: ProductService().getAllProductsStream(),
                      builder: (context, snap) {
                        final products = snap.data ?? <ProductModel>[];
                        return ElevatedButton.icon(
                          icon: const Icon(Icons.filter_list, size: 20),
                          label: const Text('Filters'),
                          onPressed: () =>
                              _openFilterSheet(context, products),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0085FF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),
        // ─── Listado de productos ────────────────────────────────────────
        StreamBuilder<List<ProductModel>>(
          stream: ProductService().getAllProductsStream(),
          builder: (context, snap) {
            if (snap.hasError) {
              return const Center(
                child: Text('Something went wrong',
                    style: TextStyle(color: Colors.red)),
              );
            }
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final products = snap.data!;
            final filtered = _applyFilters(products);

            return Column(
              children: [
                // Contador de resultados
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '${filtered.length} products found',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),

                // Rejilla de productos
                if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text('No products found.',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  )
                else
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                          MediaQuery.of(context).size.width > 800 ? 3 : 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, i) =>
                            ProductCard(product: filtered[i]),
                      ),
                    ),
                  ),

                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ],
    );
  }

  /// Filtrado profesional: normalize, match texto y categoría (por slug), y ordena
  List<ProductModel> _applyFilters(List<ProductModel> items) {
    final query = _searchQuery.trim().toLowerCase();
    final normalizedSelected =
    _selectedCategories.map((c) => c.trim().toLowerCase()).toList();

    List<ProductModel> result = items.where((p) {
      final title = p.title.trim().toLowerCase();
      final productSlug = _slugify(p.category);

      final matchesText = query.isEmpty || title.contains(query);
      final matchesCat =
          normalizedSelected.isEmpty || normalizedSelected.contains(productSlug);

      return matchesText && matchesCat;
    }).toList();

    if (normalizedSelected.isNotEmpty) {
      result.sort((a, b) {
        final aSlug = _slugify(a.category);
        final bSlug = _slugify(b.category);
        final aIn = normalizedSelected.contains(aSlug);
        final bIn = normalizedSelected.contains(bSlug);
        if (aIn && !bIn) return -1;
        if (!aIn && bIn) return 1;
        return a.title.compareTo(b.title);
      });
    } else {
      result.sort((a, b) => a.title.compareTo(b.title));
    }

    return result;
  }

  /// Abre el BottomSheet cargando las categorías desde la base de datos
  Future<void> _openFilterSheet(
      BuildContext context, List<ProductModel> products) async {
    final categories = await CategoryService().getAllCategories();

    // Contar cuántos productos hay por cada categoría (usando slugify)
    final catCounts = <String, int>{};
    for (final cat in categories) {
      final count = products
          .map((p) => _slugify(p.category))
          .where((s) => s == cat.slug)
          .length;
      catCounts[cat.slug] = count;
    }

    String localSearch = '';
    List<String> tempSelected = List.of(_selectedCategories);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF222222),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) {
          final filteredCats = categories
              .where((c) => c.name.toLowerCase().contains(localSearch))
              .toList();

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select categories',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (v) => setModalState(() => localSearch = v),
                  decoration: InputDecoration(
                    hintText: 'Search categories...',
                    hintStyle: const TextStyle(color: Color(0xFF888888)),
                    prefixIcon:
                    const Icon(Icons.search, color: Color(0xFF888888)),
                    filled: true,
                    fillColor: const Color(0xFF333333),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: filteredCats.map((cat) {
                    return FilterChip(
                      label: Text(
                        '${cat.name} (${catCounts[cat.slug] ?? 0})',
                        style: const TextStyle(color: Colors.white),
                      ),
                      selected: tempSelected.contains(cat.slug),
                      onSelected: (sel) => setModalState(() => sel
                          ? tempSelected.add(cat.slug)
                          : tempSelected.remove(cat.slug)),
                      selectedColor: const Color(0xFF005BB5),
                      backgroundColor: const Color(0xFF333333),
                      checkmarkColor: Colors.white,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() => _selectedCategories.clear());
                        Navigator.pop(ctx);
                      },
                      child: const Text('Clear All',
                          style: TextStyle(color: Colors.white70)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _selectedCategories = tempSelected);
                        Navigator.pop(ctx);
                      },
                      child: const Text('Apply Filters'),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
