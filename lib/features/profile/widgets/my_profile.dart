import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyProfile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onEditProfile;
  final VoidCallback onVerifyAccount;
  final VoidCallback onAddProduct;

  const MyProfile({
    Key? key,
    required this.user,
    required this.onEditProfile,
    required this.onVerifyAccount,
    required this.onAddProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final city = user.address?.city ?? '';
    final state = user.address?.state ?? '';
    final location = [city, state].where((s) => s.isNotEmpty).join(', ');
    final memberSince = DateFormat('MMMM yyyy').format(user.createdAt);
    final bio = user.preferences?.bio ?? '';
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final paymentMethods = user.paymentMethods ?? {};

    const defaultImageUrl =
        'https://res.cloudinary.com/do9dtxrvh/image/upload/v1742413057/Untitled_design_1_hvuwau.png';

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.blueGrey,
              child: ClipOval(
                child: Image.network(
                  user.profileImageUrl ?? defaultImageUrl,
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                  errorBuilder: (context, error, stackTrace) => Text(
                    user.fullName.isNotEmpty ? user.fullName[0] : '?',
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user.fullName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '@${user.username}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Member since $memberSince',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white60, fontSize: 12),
            ),
            if (location.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                location,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
            if (bio.isNotEmpty) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  bio,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onEditProfile,
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: onVerifyAccount,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white70),
                  ),
                  child: const Text(
                    'Verify Account',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Métodos de Pago desplegable
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                  title: const Text(
                    'Gestionar Métodos de Pago',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  collapsedIconColor: Colors.white,
                  iconColor: Colors.white,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          const Text(
                            'Agrega, remueve y organiza tus métodos de pago como widgets',
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final method = await showMenu<String>(
                                context: context,
                                position: RelativeRect.fromLTRB(100, 100, 100, 100),
                                items: const [
                                  PopupMenuItem(value: 'binance', child: Text('Binance Pay')),
                                  PopupMenuItem(value: 'transferencia', child: Text('Transferencia')),
                                  PopupMenuItem(value: 'pagoMovil', child: Text('Pago Móvil')),
                                ],
                              );

                              if (method == null) return;

                              final data = await showDialog<Map<String, String>>(
                                context: context,
                                builder: (ctx) {
                                  final formKey = GlobalKey<FormState>();
                                  final values = <String, String>{};

                                  List<Widget> fields;
                                  switch (method) {
                                    case 'binance':
                                      fields = [
                                        TextFormField(
                                          decoration: const InputDecoration(labelText: 'Correo o tag de Binance'),
                                          onSaved: (val) => values['binanceUser'] = val ?? '',
                                          validator: (val) => val == null || val.isEmpty ? 'Requerido' : null,
                                        ),
                                      ];
                                      break;
                                    case 'transferencia':
                                      fields = [
                                        TextFormField(
                                          decoration: const InputDecoration(labelText: 'Banco'),
                                          onSaved: (val) => values['bank'] = val ?? '',
                                        ),
                                        TextFormField(
                                          decoration: const InputDecoration(labelText: 'Número de cuenta'),
                                          onSaved: (val) => values['accountNumber'] = val ?? '',
                                        ),
                                        TextFormField(
                                          decoration: const InputDecoration(labelText: 'Titular'),
                                          onSaved: (val) => values['titular'] = val ?? '',
                                        ),
                                      ];
                                      break;
                                    case 'pagoMovil':
                                      fields = [
                                        TextFormField(
                                          decoration: const InputDecoration(labelText: 'Banco'),
                                          onSaved: (val) => values['bank'] = val ?? '',
                                        ),
                                        TextFormField(
                                          decoration: const InputDecoration(labelText: 'Teléfono'),
                                          onSaved: (val) => values['phoneNumber'] = val ?? '',
                                        ),
                                        TextFormField(
                                          decoration: const InputDecoration(labelText: 'Cédula o RIF'),
                                          onSaved: (val) => values['idOrRif'] = val ?? '',
                                        ),
                                        TextFormField(
                                          decoration: const InputDecoration(labelText: 'Titular'),
                                          onSaved: (val) => values['titular'] = val ?? '',
                                        ),
                                      ];
                                      break;
                                    default:
                                      fields = [const Text('Método no reconocido')];
                                  }

                                  return AlertDialog(
                                    title: Text('Agregar $method'),
                                    content: Form(
                                      key: formKey,
                                      child: SingleChildScrollView(
                                        child: Column(children: fields),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: const Text('Cancelar'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            formKey.currentState!.save();
                                            Navigator.pop(ctx, values);
                                          }
                                        },
                                        child: const Text('Guardar'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (data != null) {
                                await FirebaseFirestore.instance.collection('users').doc(uid).update({
                                  'paymentMethods.$method': data,
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Método $method guardado correctamente')),
                                );
                              }
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Añadir'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Métodos Activos',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 12),

                          if (paymentMethods['binance'] != null &&
                              (paymentMethods['binance']?['binanceUser']?.isNotEmpty ?? false))
                            _buildPaymentCard(
                              context,
                              title: 'Binance Pay',
                              subtitle: paymentMethods['binance']?['binanceUser'],
                              icon: Icons.credit_card,
                              isPrimary: true,
                            ),

                          if (paymentMethods['transferencia'] != null &&
                              (paymentMethods['transferencia']?['accountNumber']?.isNotEmpty ?? false))
                            _buildPaymentCard(
                              context,
                              title: 'Transferencia',
                              subtitle: paymentMethods['transferencia']?['bank'],
                              icon: Icons.account_balance,
                            ),

                          if (paymentMethods['pagoMovil'] != null &&
                              (paymentMethods['pagoMovil']?['phoneNumber']?.isNotEmpty ?? false))
                            _buildPaymentCard(
                              context,
                              title: 'Pago Móvil',
                              subtitle: paymentMethods['pagoMovil']?['phoneNumber'],
                              icon: Icons.attach_money,
                            ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        bool isPrimary = false,
      }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 32, color: Colors.amber),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(subtitle, style: const TextStyle(color: Colors.white70)),
                ],
              ),
              const Spacer(),
              if (isPrimary)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Primary', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (!isPrimary)
                TextButton(
                  onPressed: () {
                    // TODO: set as primary
                  },
                  child: const Text('Set as Primary'),
                ),
              TextButton(
                onPressed: () {
                  // TODO: editar método
                },
                child: const Text('Edit'),
              ),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  final uid = FirebaseAuth.instance.currentUser!.uid;
                  String methodKey = '';

                  if (title.toLowerCase().contains('binance')) {
                    methodKey = 'binance';
                  } else if (title.toLowerCase().contains('transferencia')) {
                    methodKey = 'transferencia';
                  } else if (title.toLowerCase().contains('pago')) {
                    methodKey = 'pagoMovil';
                  }

                  if (methodKey.isNotEmpty) {
                    await FirebaseFirestore.instance.collection('users').doc(uid).update({
                      'paymentMethods.$methodKey': FieldValue.delete(),
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Método $title eliminado correctamente')),
                    );
                  }
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Remove'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}