import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;


class ProfileSettings extends StatefulWidget {
  final User user;
  const ProfileSettings({required this.user, super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool _darkMode = false;
  bool _notificationsEnabled = true;
  String _language = 'es';
  String? _photoUrl;
  bool _isVerifying = false;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.uid)
        .get();
    final data = doc.data();
    if (data != null) {
      _nameController.text = data['name'] ?? '';
      _phoneController.text = data['phone'] ?? '';
      _locationController.text = data['location'] ?? '';
      _bioController.text = data['bio'] ?? '';
      _language = data['preferences']?['language'] ?? 'es';
      _darkMode = data['preferences']?['darkMode'] ?? false;
      _notificationsEnabled = data['preferences']?['notifications'] ?? true;
      _photoUrl = data['profileImageUrl'];
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final url = await uploadImageToCloudinary(picked); //
      if (url != null) {
        setState(() => _photoUrl = url);
      }
    }
  }

  Future<String?> uploadImageToCloudinary(XFile imageFile) async {
    const cloudName = 'dmjwqsx8l';
    const uploadPreset = 'unsigned_renty';

    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['upload_preset'] = uploadPreset;

      if (kIsWeb) {
        // Para Web
        final bytes = await imageFile.readAsBytes();
        final multipartFile = http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: imageFile.name,
        );
        request.files.add(multipartFile);
      } else {
        // Para Mobile
        final multipartFile = await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
        );
        request.files.add(multipartFile);
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);

      if (response.statusCode == 200) {
        return data['secure_url'];
      } else {
        debugPrint('Error al subir la imagen: $responseData');
        return null;
      }
    } catch (e) {
      debugPrint('Excepción en subida: $e');
      return null;
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('users').doc(widget.user.uid).update({
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'location': _locationController.text.trim(),
        'bio': _bioController.text.trim(),
        'profileImageUrl': _photoUrl,
        'preferences.language': _language,
        'preferences.darkMode': _darkMode,
        'preferences.notifications': _notificationsEnabled,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado')),
      );
    }
  }

  Future<void> _verifyEmail() async {
    setState(() => _isVerifying = true);
    await widget.user.sendEmailVerification();
    setState(() => _isVerifying = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Correo de verificación enviado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white12),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Update your personal information',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _photoUrl != null ? NetworkImage(_photoUrl!) : null,
                    backgroundColor: Colors.grey[800],
                    child: _photoUrl == null
                        ? const Icon(Icons.camera_alt, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Full Name'),
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.user.email,
                        enabled: false,
                        decoration: const InputDecoration(labelText: 'Email Address'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(labelText: 'Phone Number'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _locationController,
                        decoration: const InputDecoration(labelText: 'Location'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bioController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Bio'),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Dark Mode', style: TextStyle(color: Colors.white)),
                  value: _darkMode,
                  onChanged: (v) => setState(() => _darkMode = v),
                ),
                Row(
                  children: [
                    const Text('Language:', style: TextStyle(color: Colors.white)),
                    const SizedBox(width: 12),
                    DropdownButton<String>(
                      value: _language,
                      dropdownColor: Colors.grey[850],
                      style: const TextStyle(color: Colors.white),
                      onChanged: (v) => setState(() => _language = v!),
                      items: const [
                        DropdownMenuItem(value: 'es', child: Text('Español')),
                        DropdownMenuItem(value: 'en', child: Text('English')),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Checkbox(
                      value: _notificationsEnabled,
                      onChanged: (val) => setState(() => _notificationsEnabled = val!),
                    ),
                    const Expanded(
                      child: Text(
                        'Receive email notifications about new messages and updates',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _saveProfile,
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (!widget.user.emailVerified)
                  ElevatedButton(
                    onPressed: _isVerifying ? null : _verifyEmail,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      _isVerifying ? 'Sending...' : 'Verify Email',
                    ),
                  )
                else
                  const Text('✅ Email Verified', style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
