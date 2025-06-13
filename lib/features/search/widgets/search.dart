import 'package:flutter/material.dart';
import 'package:renty/features/products/models/product_model.dart';
import 'package:renty/features/products/services/product_service.dart';
import 'package:renty/features/products/widgets/product_grib.dart';
import 'package:renty/features/search/widgets/product_filter_sheet.dart';

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
  final GlobalKey _filterButtonKey = GlobalKey();
  String _searchQuery = '';
  late List<String> _selectedCategories;
  RangeValues _selectedPriceRange = const RangeValues(0, 1000);
  String _selectedCity = '';
  bool _sortByPopular = false;
  bool _sortByViews = false;

  @override
  void initState() {
    super.initState();
    _selectedCategories = List.of(widget.initialSelectedCategories);
  }

  String _slugify(String input) {
    return input
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w]+'), '-')
        .replaceAll(RegExp(r'(^-+|-+\$)'), '');
  }

  void _showFilterPopup(GlobalKey key) {
    final overlay = Overlay.of(context);
    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    late OverlayEntry overlayEntry; // 👈 se declara antes

    overlayEntry = OverlayEntry(
      builder: (context) =>
          Stack(
            children: [
              // Toca fuera para cerrar
              GestureDetector(
                onTap: () => overlayEntry.remove(),
                child: Container(color: Colors.transparent),
              ),
              Positioned(
                top: position.dy + renderBox.size.height + 8,
                left: position.dx,
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF222222),
                  child: Container(
                    width: 320,
                    padding: const EdgeInsets.all(12),
                    child: ProductFilterSheet(
                      selectedCategories: _selectedCategories,
                      selectedPriceRange: _selectedPriceRange,
                      selectedCity: _selectedCity,
                      mostPopular: _sortByPopular,
                      mostViewed: _sortByViews,
                      onApply: ({
                        required categories,
                        required priceRange,
                        required city,
                        required mostPopular,
                        required mostViewed,
                      }) {
                        setState(() {
                          _selectedCategories = categories;
                          _selectedPriceRange = priceRange;
                          _selectedCity = city;
                          _sortByPopular = mostPopular;
                          _sortByViews = mostViewed;
                        });
                        overlayEntry.remove();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
    );

    overlay.insert(overlayEntry);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 32),

        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Material(
              elevation: 6,
              shadowColor: Colors.black54,
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF222222),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (v) => setState(() => _searchQuery = v),
                        decoration: InputDecoration(
                          hintText: 'Search for anything to rent...',
                          hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                          prefixIcon: const Icon(Icons.search,
                              color: Color(0xFFAAAAAA)),
                          filled: true,
                          fillColor: const Color(0xFF2A2A2A),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      key: _filterButtonKey,
                      icon: const Icon(Icons.filter_list, size: 20),
                      label: const Text('Filters'),
                      onPressed: () => _showFilterPopup(_filterButtonKey),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0085FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 16),
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '${filtered.length} products found',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
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
                      child: ProductGrid(
                        products: filtered,
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

  List<ProductModel> _applyFilters(List<ProductModel> items) {
    final query = _searchQuery.trim().toLowerCase();
    final normalizedSelected = _selectedCategories.map((c) =>
        c.trim().toLowerCase()).toList();

    List<ProductModel> result = items.where((p) {
      final title = p.title.trim().toLowerCase();
      final productSlug = _slugify(p.category);
      final city = (p.location['city'] ?? '').toString().toLowerCase();
      final price = p.rentalPrices['day'] ?? 0;

      final matchesText = query.isEmpty || title.contains(query);
      final matchesCategory = normalizedSelected.isEmpty ||
          normalizedSelected.contains(productSlug);
      final matchesCity = _selectedCity.isEmpty ||
          city.contains(_selectedCity.toLowerCase());
      final matchesPrice = price >= _selectedPriceRange.start &&
          price <= _selectedPriceRange.end;

      return matchesText && matchesCategory && matchesCity && matchesPrice;
    }).toList();

    if (_sortByPopular) {
      result.sort((a, b) => b.rating.compareTo(a.rating));
    } else if (_sortByViews) {
      result.sort((a, b) => (b.views ?? 0).compareTo(a.views ?? 0));
    } else {
      result.sort((a, b) => a.title.compareTo(b.title));
    }

    return result;
  }
}