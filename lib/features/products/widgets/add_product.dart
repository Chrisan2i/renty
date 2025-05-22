import 'dart:io';
import 'dart:convert';
import 'dart:typed_data'; // Added import for Uint8List
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renty/features/products/models/product_model.dart';
import 'package:renty/features/products/services/product_service.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _categories = ['Tecnología', 'Deportes', 'Herramientas', 'Vehículos'];
  String _selectedCategory = 'Tecnología';
  bool _isSubmitting = false;
  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile>? picked = await _picker.pickMultiImage();
      if (picked != null && picked.isNotEmpty) {
        setState(() {
          _images.clear();
          _images.addAll(picked);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al seleccionar imágenes: $e')),
      );
    }
  }

  Future<List<String>> _uploadImagesToCloudinary() async {
    const cloudName = 'dmjwqsx8l'; // Your Cloudinary cloud name
    const uploadPreset = 'unsigned_renty'; // Your Cloudinary upload preset
    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    List<String> imageUrls = [];

    for (var image in _images) {
      try {
        var request = http.MultipartRequest('POST', url);
        request.fields['upload_preset'] = uploadPreset;

        if (kIsWeb) {
          // For Web
          final bytes = await image.readAsBytes();
          final multipartFile = http.MultipartFile.fromBytes(
            'file',
            bytes,
            filename: image.name,
          );
          request.files.add(multipartFile);
        } else {
          // For Mobile
          final multipartFile = await http.MultipartFile.fromPath(
            'file',
            image.path,
          );
          request.files.add(multipartFile);
        }

        final response = await request.send();
        final responseData = await response.stream.bytesToString();
        final data = json.decode(responseData);

        if (response.statusCode == 200) {
          imageUrls.add(data['secure_url']);
        } else {
          debugPrint('Error al subir la imagen: $responseData');
          throw Exception('Failed to upload image: ${image.name}');
        }
      } catch (e) {
        debugPrint('Excepción en subida: $e');
        throw Exception('Error uploading image: ${image.name}');
      }
    }
    return imageUrls;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agrega al menos una foto')),
      );
      return;
    }
    setState(() => _isSubmitting = true);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes iniciar sesión primero.')),
      );
      setState(() => _isSubmitting = false);
      return;
    }

    try {
      // Upload images to Cloudinary
      final imageUrls = await _uploadImagesToCloudinary();

      final now = DateTime.now();
      final product = ProductModel(
        productId: '',
        ownerId: user.uid,
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        category: _selectedCategory,
        pricePerDay: double.tryParse(_priceCtrl.text) ?? 0,
        images: imageUrls, // Store Cloudinary URLs
        isAvailable: true,
        rating: 0,
        totalReviews: 0,
        createdAt: now,
        updatedAt: now,
        location: {'city': '', 'state': '', 'country': '', 'latitude': null, 'longitude': null},
      );

      await ProductService().addProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto publicado exitosamente')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image selection
            GestureDetector(
              onTap: _pickImages,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white24),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _images.isEmpty
                    ? const Center(
                  child: Text(
                    'Tocar para agregar fotos',
                    style: TextStyle(color: Colors.white70),
                  ),
                )
                    : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: FutureBuilder<Uint8List>(
                        future: _images[i].readAsBytes(),
                        builder: (context, snap) {
                          if (snap.hasData) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                snap.data!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.white10,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Título',
                filled: true,
                fillColor: Color(0xFF222222),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.white),
              validator: (v) => v!.trim().isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                filled: true,
                fillColor: Color(0xFF222222),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              validator: (v) => v!.trim().isEmpty ? 'Requerido' : null,
            ),
            const SizedBox(height: 16),

            // Price and category
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Precio por día',
                      filled: true,
                      fillColor: Color(0xFF222222),
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (v) {
                      final d = double.tryParse(v!);
                      if (d == null || d <= 0) return 'Inválido';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Categoría',
                      filled: true,
                      fillColor: Color(0xFF222222),
                      border: OutlineInputBorder(),
                    ),
                    dropdownColor: const Color(0xFF222222),
                    items: _categories
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedCategory = v!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Submit button
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0085FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
                  : const Text('Publicar producto',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}