import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/models/product_model.dart';
import 'package:renty/services/product_service.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  String _selectedCategory = 'Tecnología';

  final List<String> _categories = [
    'Tecnología',
    'Deportes',
    'Herramientas',
    'Electrodomésticos',
    'Vehículos',
  ];

  bool _isSubmitting = false;

  void _submitProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final now = DateTime.now();

      final newProduct = ProductModel(
        productId: '',
        ownerId: user.uid,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        pricePerDay: double.parse(_priceController.text),
        images: [], // se puede integrar más adelante
        isAvailable: true,
        rating: 0,
        totalReviews: 0,
        createdAt: now,
        updatedAt: now,
        location: {
          'city': '',
          'state': '',
          'country': '',
          'latitude': null,
          'longitude': null,
        },
      );

      try {
        await ProductService().addProduct(newProduct);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto publicado exitosamente')),
        );

        Navigator.pop(context); // volver a la pantalla anterior
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      } finally {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Publicar producto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Este campo es obligatorio'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? 'Este campo es obligatorio'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration:
                const InputDecoration(labelText: 'Precio por día (USD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa un precio';
                  }
                  final parsed = double.tryParse(value);
                  if (parsed == null || parsed <= 0) {
                    return 'Precio inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedCategory = value!);
                },
                decoration: const InputDecoration(labelText: 'Categoría'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitProduct,
                  child: _isSubmitting
                      ? const CircularProgressIndicator()
                      : const Text('Publicar producto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
