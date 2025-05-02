import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _UsernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Crear cuenta con correo y contraseña
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        User? user = userCredential.user;

        if (user != null) {
          // Guardar información del usuario en Firestore
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'username': _UsernameController.text.trim(),
            'fullName': _fullNameController.text.trim(),
            'email': _emailController.text.trim(),
            'phone': '',
            'profileImageUrl': '',
            'location': '',
            'createdAt': FieldValue.serverTimestamp(),
            'lastLoginAt': FieldValue.serverTimestamp(),
            'role': 'user',
            'identityVerification': {
              'type': '',
              'number': '',
              'frontImageUrl': '',
              'backImageUrl': '',
              'selfieWithIdUrl': '',
              'faceScanData': null,
              'verified': false,
              'verifiedBy': '',
              'verifiedAt': null,
            },
            'address': {
              'street': '',
              'city': '',
              'state': '',
              'zip': '',
              'country': '',
              'latitude': null,
              'longitude': null,
            },
            'rating': 0,
            'totalRentsMade': 0,
            'totalRentsReceived': 0,
            'wallet': {
              'balance': 0.0,
              'currency': 'USD',
              'lastUpdated': FieldValue.serverTimestamp(),
            },
            'paymentMethods': [],
            'preferences': {
              'language': 'es',
              'receiveNotifications': true,
              'darkMode': false,
            },
            'blocked': false,
            'banReason': null,
            'reports': 0,
            'notesByAdmin': '',
          });

          // Mostrar mensaje de éxito
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cuenta creada exitosamente'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

          // Redirigir al Landing Page ya logueado
          Navigator.pushReplacementNamed(context, '/landing');
        } else {
          throw Exception('No se pudo obtener el usuario');
        }
      } on FirebaseAuthException catch (e) {
        String message = 'Error al registrar';
        if (e.code == 'email-already-in-use') {
          message = 'Este correo ya está en uso.';
        } else if (e.code == 'invalid-email') {
          message = 'Correo inválido.';
        } else if (e.code == 'weak-password') {
          message = 'Contraseña muy débil.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF222222),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/logo.png', height: 40),
                    const SizedBox(height: 24),
                    const Text(
                      "Create Account",
                      style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Sign up to get started with your new account",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: () {},
                      icon: Image.network(
                        'https://res.cloudinary.com/doyt5r47e/image/upload/v1746128729/google_dogxyt.webp',
                        height: 18,
                      ),
                        label: const Text("Continue with Google"),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: const [
                        Expanded(child: Divider(color: Colors.white24)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text("or",
                              style: TextStyle(color: Colors.grey)),
                        ),
                        Expanded(child: Divider(color: Colors.white24)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Full Name", style: TextStyle(color: Colors
                          .grey)),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                        hintText: "Enter your full name",
                        filled: true,
                        fillColor: Color(0xFF111111),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                      ),
                      validator: (value) =>
                      value!.trim().isEmpty ? 'Name is required' : null,
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Username", style: TextStyle(color: Colors
                          .grey)),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _UsernameController,
                      decoration: const InputDecoration(
                        hintText: "Enter a Username",
                        filled: true,
                        fillColor: Color(0xFF111111),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                      ),
                      validator: (value) =>
                      value!.trim().isEmpty ? 'username is required' : null,
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "Email Address", style: TextStyle(color: Colors
                          .grey)),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Enter your email",
                        filled: true,
                        fillColor: Color(0xFF111111),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Email is required';
                        if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Password", style: TextStyle(color: Colors
                          .grey)),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Create a password",
                        filled: true,
                        fillColor: Color(0xFF111111),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Password is required';
                        if (value.length < 6)
                          return 'Password must be at least 6 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "Confirm Password", style: TextStyle(color: Colors
                          .grey)),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Confirm your password",
                        filled: true,
                        fillColor: Color(0xFF111111),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0085FF),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _register ,
                        child: const Text(
                          "Create Account",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Color(0xFF0085FF)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}