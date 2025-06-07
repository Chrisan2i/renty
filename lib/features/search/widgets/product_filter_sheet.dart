import 'package:flutter/material.dart';
import 'package:renty/features/products/models/product_model.dart';
import 'package:renty/features/categories/services/category_service.dart';
import 'package:renty/features/categories/models/category_model.dart';

class ProductFilterSheet extends StatefulWidget {
  final List<String> selectedCategories;
  final RangeValues selectedPriceRange;
  final String selectedCity;
  final bool mostPopular;
  final bool mostViewed;
  final Function({
  required List<String> categories,
  required RangeValues priceRange,
  required String city,
  required bool mostPopular,
  required bool mostViewed,
  }) onApply;

  const ProductFilterSheet({
    Key? key,
    required this.selectedCategories,
    required this.selectedPriceRange,
    required this.selectedCity,
    required this.mostPopular,
    required this.mostViewed,
    required this.onApply,
  }) : super(key: key);

  @override
  State<ProductFilterSheet> createState() => _ProductFilterSheetState();
}

class _ProductFilterSheetState extends State<ProductFilterSheet> {
  List<String> _tempCategories = [];
  RangeValues _tempPrice = const RangeValues(0, 1000);
  String _tempCity = '';
  bool _tempPopular = false;
  bool _tempViewed = false;
  List<CategoryModel> _allCategories = [];
  bool _isLoadingCategories = true; // ✅ nuevo

  @override
  void initState() {
    super.initState();
    _tempCategories = List.from(widget.selectedCategories);
    _tempPrice = widget.selectedPriceRange;
    _tempCity = widget.selectedCity;
    _tempPopular = widget.mostPopular;
    _tempViewed = widget.mostViewed;
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoadingCategories = true);
    final cats = await CategoryService().getAllCategories();
    setState(() {
      _allCategories = cats;
      _isLoadingCategories = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.8;

    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Filters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 12),

          const Text('Categories', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),

          Container(
            constraints: const BoxConstraints(
              maxHeight: 120, // altura máxima para scroll si hay muchas categorías
            ),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _allCategories.map((cat) {
                  return FilterChip(
                    label: Text(cat.name),
                    selected: _tempCategories.contains(cat.slug),
                    onSelected: (sel) {
                      setState(() {
                        sel
                            ? _tempCategories.add(cat.slug)
                            : _tempCategories.remove(cat.slug);
                      });
                    },
                    selectedColor: const Color(0xFF0085FF),
                    backgroundColor: const Color(0xFF333333),
                    labelStyle: const TextStyle(color: Colors.white),
                    checkmarkColor: Colors.white,
                  );
                }).toList(),
              ),
            ),
          ),



          const SizedBox(height: 16),
          const Text('Price Range (\$)', style: TextStyle(color: Colors.white70)),
          RangeSlider(
            values: _tempPrice,
            min: 0,
            max: 5000,
            divisions: 100,
            labels: RangeLabels(
              _tempPrice.start.round().toString(),
              _tempPrice.end.round().toString(),
            ),
            onChanged: (range) => setState(() => _tempPrice = range),
            activeColor: const Color(0xFF0085FF),
            inactiveColor: Colors.white24,
          ),

          const SizedBox(height: 16),
          const Text('City', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 4),
          TextField(
            onChanged: (v) => setState(() => _tempCity = v),
            controller: TextEditingController(text: _tempCity),
            decoration: const InputDecoration(
              hintText: 'Enter city...',
              hintStyle: TextStyle(color: Color(0xFF888888)),
              filled: true,
              fillColor: Color(0xFF333333),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            style: const TextStyle(color: Colors.white),
          ),

          const SizedBox(height: 16),
          const Text('Quick Filters', style: TextStyle(color: Colors.white70)),
          CheckboxListTile(
            value: _tempPopular,
            onChanged: (val) => setState(() => _tempPopular = val ?? false),
            title: const Text('Most Popular (by rating)', style: TextStyle(color: Colors.white)),
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xFF0085FF),
            checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          CheckboxListTile(
            value: _tempViewed,
            onChanged: (val) => setState(() => _tempViewed = val ?? false),
            title: const Text('Most Viewed', style: TextStyle(color: Colors.white)),
            contentPadding: EdgeInsets.zero,
            activeColor: const Color(0xFF0085FF),
            checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _tempCategories.clear();
                    _tempPrice = const RangeValues(0, 1000);
                    _tempCity = '';
                    _tempPopular = false;
                    _tempViewed = false;
                  });
                },
                child: const Text('Clear All', style: TextStyle(color: Colors.white70)),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  widget.onApply(
                    categories: _tempCategories,
                    priceRange: _tempPrice,
                    city: _tempCity,
                    mostPopular: _tempPopular,
                    mostViewed: _tempViewed,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0085FF),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Apply Filters'),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}
