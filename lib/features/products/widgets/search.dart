import 'package:flutter/material.dart';
import 'package:renty/features/products/models/product_model.dart';
import 'package:renty/features/products/services/product_service.dart';
import 'package:renty/features/products/widgets/product_card.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _searchQuery = '';
  List<String> _selectedCategories = [];

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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (v) => setState(() => _searchQuery = v),
                        decoration: InputDecoration(
                          hintText: 'Search for anything to rent...',
                          hintStyle: const TextStyle(color: Color(0xFF888888)),
                          prefixIcon: const Icon(Icons.search, color: Color(0xFF888888)),
                          filled: true,
                          fillColor: const Color(0xFF333333),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.filter_list, size: 20),
                      label: const Text('Filters'),
                      onPressed: () => _openFilterSheet(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0085FF),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
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
              return const Center(child: Text('Something went wrong', style: TextStyle(color: Colors.red)));
            }
            if (!snap.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final products = snap.data!;
            final filtered = products.where((p) {
              final matchQuery = p.title.toLowerCase().contains(_searchQuery.toLowerCase());
              final matchCat = _selectedCategories.isEmpty || _selectedCategories.contains(p.category);
              return matchQuery && matchCat;
            }).toList();

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
                    child: Text('No products found.', style: TextStyle(color: Colors.white, fontSize: 18)),
                  )
                else
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, i) => ProductCard(product: filtered[i]),
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

  void _openFilterSheet(BuildContext context) {
    // Recupera la última lista cacheada
    final products = ProductService().lastFetchedProducts;

    // Calcula el count por categoría
    final catCounts = <String, int>{};
    for (var p in products) {
      catCounts[p.category] = (catCounts[p.category] ?? 0) + 1;
    }
    final categories = catCounts.keys.toList()..sort();

    String localSearch = '';
    List<String> tempSelected = List.of(_selectedCategories);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF222222),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) {
          // Filtra chips por búsqueda interna
          final filteredCats = categories
              .where((c) => c.toLowerCase().contains(localSearch.toLowerCase()))
              .toList();

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select categories', style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 8),
                // Buscador interno de categorías
                TextField(
                  onChanged: (v) => setModalState(() => localSearch = v),
                  decoration: InputDecoration(
                    hintText: 'Search categories...',
                    hintStyle: const TextStyle(color: Color(0xFF888888)),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF888888)),
                    filled: true,
                    fillColor: const Color(0xFF333333),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 12),
                // Chips dinámicos con count
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: filteredCats.map((cat) {
                    return FilterChip(
                      label: Text('$cat (${catCounts[cat]})', style: const TextStyle(color: Colors.white)),
                      selected: tempSelected.contains(cat),
                      onSelected: (sel) => setModalState(() {
                        sel ? tempSelected.add(cat) : tempSelected.remove(cat);
                      }),
                      selectedColor: const Color(0xFF005BB5),
                      backgroundColor: const Color(0xFF333333),
                      checkmarkColor: Colors.white,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // Acciones Clear / Apply
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() => _selectedCategories.clear());
                        Navigator.pop(ctx);
                      },
                      child: const Text('Clear All', style: TextStyle(color: Colors.white70)),
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

