import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:renty/features/products/models/product_model.dart';
import 'package:renty/features/products/services/product_service.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

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

  List<Map<String, dynamic>> _categories = [];
  String? _selectedCategory;

  bool _isSubmitting = false;
  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final snapshot = await FirebaseFirestore.instance.collection('categories').where('isActive', isEqualTo: true).get();
    setState(() {
      _categories = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'name': data['name'],
          'slug': data['slug'],
          'iconUrl': data['iconUrl'],
        };
      }).toList();
      if (_categories.isNotEmpty) {
        _selectedCategory = _categories.first['slug'];
      }
    });
  }

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
    const cloudName = 'dmjwqsx8l';
    const uploadPreset = 'unsigned_renty';
    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    List<String> imageUrls = [];

    for (var image in _images) {
      try {
        var request = http.MultipartRequest('POST', url);
        request.fields['upload_preset'] = uploadPreset;

        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          final multipartFile = http.MultipartFile.fromBytes(
            'file',
            bytes,
            filename: image.name,
          );
          request.files.add(multipartFile);
        } else {
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
          throw Exception('Error al subir imagen');
        }
      } catch (e) {
        rethrow;
      }
    }
    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    if (_categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

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

            // Price and Category
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
                        .map((c) => DropdownMenuItem<String>(
                      value: c['slug'],
                      child: Text(
                        c['name'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedCategory = v!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Submit
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0085FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                height: 24,
                width: 24,
                child:
                CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
                  : const Text(
                'Publicar producto',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }


  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final imageUrls = await _uploadImagesToCloudinary();
      final now = DateTime.now();
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        throw Exception('Usuario no autenticado');
      }

      final productId = FirebaseFirestore.instance.collection('products').doc().id;

      final product = ProductModel(
        productId: productId,
        ownerId: userId,
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        category: _selectedCategory ?? '',
        pricePerDay: double.parse(_priceCtrl.text.trim()),
        images: imageUrls,
        isAvailable: true,
        rating: 0.0,
        totalReviews: 0,
        createdAt: now,
        updatedAt: now,
        location: {
          "lat": 0.0,
          "lng": 0.0,
          "address": "Dirección no especificada",
        },
      );

      await ProductService().addProduct(product);

      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e, stack) {
      debugPrint('Error al publicar producto: $e\n$stack');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al publicar: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}