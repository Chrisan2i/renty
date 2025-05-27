import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class AccountVerificationView extends StatefulWidget {
  const AccountVerificationView({super.key});

  @override
  State<AccountVerificationView> createState() => _AccountVerificationViewState();
}

class _AccountVerificationViewState extends State<AccountVerificationView> {
  final picker = ImagePicker();
  XFile? frontIdImage;
  XFile? backIdImage;
  XFile? selfieImage;
  XFile? residenceProofImage;
  bool isLoading = false;

  Future<XFile?> _pickImage() async {
    return await picker.pickImage(source: ImageSource.gallery);
  }

  Future<String> uploadImage(XFile pickedFile, String name) async {
    const cloudName = 'dmjwqsx8l';
    const uploadPreset = 'unsigned_renty';
    final mimeType = lookupMimeType(pickedFile.path) ?? 'image/jpeg';
    final bytes = await pickedFile.readAsBytes();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..fields['public_id'] = name
      ..files.add(http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: pickedFile.name,
        contentType: MediaType.parse(mimeType),
      ));

    final response = await request.send();
    final responseBody = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final data = jsonDecode(responseBody.body);
      return data['secure_url'];
    } else {
      throw Exception('Error al subir imagen: ${response.statusCode}');
    }
  }

  Future<void> _submitVerification() async {
    if (frontIdImage == null ||
        backIdImage == null ||
        selfieImage == null ||
        residenceProofImage == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona todas las imágenes')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final frontUrl = await uploadImage(frontIdImage!, 'cedula_frontal_$uid');
      final backUrl = await uploadImage(backIdImage!, 'cedula_trasera_$uid');
      final selfieUrl = await uploadImage(selfieImage!, 'selfie_con_cedula_$uid');
      final residenceProofUrl = await uploadImage(residenceProofImage!, 'prueba_residencia_$uid');

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'identityVerification': {
          'type': 'cedula',
          'frontImageUrl': frontUrl,
          'backImageUrl': backUrl,
          'selfieWithIdUrl': selfieUrl,
          'residenceProofUrl': residenceProofUrl,
          'submittedAt': FieldValue.serverTimestamp(),
          'status': 'under_review',
          'verified': false,
          'verifiedAt': null,
          'verifiedBy': null,
        }
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos enviados para verificación')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Widget _imageSelector(String label, XFile? imageFile, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 95,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF222222),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Icon(
              imageFile != null ? Icons.check_circle : Icons.upload_file,
              color: imageFile != null ? Colors.green : Colors.white,
              size: 40,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        elevation: 0,
        title: const Text(
          'Verificación de cuenta',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: ListView(
          children: [
            const Text(
              'Por favor sube los documentos requeridos para verificar tu identidad.',
              style: TextStyle(color: Color(0xFF999999), fontSize: 16),
            ),
            const SizedBox(height: 32),
            const Text(
              'Documento de Identidad (Cédula)',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            _imageSelector('Cédula - Parte frontal', frontIdImage, () async {
              final file = await _pickImage();
              if (file != null) setState(() => frontIdImage = file);
            }),
            _imageSelector('Cédula - Parte trasera', backIdImage, () async {
              final file = await _pickImage();
              if (file != null) setState(() => backIdImage = file);
            }),
            const SizedBox(height: 32),
            const Text(
              'Selfie con la Cédula',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            _imageSelector('Subir selfie con la cédula en la mano', selfieImage, () async {
              final file = await _pickImage();
              if (file != null) setState(() => selfieImage = file);
            }),
            const SizedBox(height: 32),
            const Text(
              'Prueba de Residencia',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            _imageSelector('Subir prueba de residencia (recibo de luz, agua, etc.)',
                residenceProofImage, () async {
                  final file = await _pickImage();
                  if (file != null) setState(() => residenceProofImage = file);
                }),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : _submitVerification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0085FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  'Enviar para revisión',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
