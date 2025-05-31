import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SendRequest extends StatefulWidget {
  final String productId;
  final String ownerId;
  final double pricePerDay;

  const SendRequest({
    super.key,
    required this.productId,
    required this.ownerId,
    required this.pricePerDay,
  });

  @override
  State<SendRequest> createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  DateTimeRange? selectedDates;
  String paymentMethod = 'Transfer';
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  int get days => selectedDates?.duration.inDays ?? 0;
  double get subtotal => widget.pricePerDay * days;
  double get vat => subtotal * 0.16;
  double get total => subtotal + vat;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate() || selectedDates == null) return;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor inicia sesión.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final now = DateTime.now();
      final rentalData = {
        'productId': widget.productId,
        'ownerId': widget.ownerId,
        'renterId': uid,
        'startDate': Timestamp.fromDate(selectedDates!.start),
        'endDate': Timestamp.fromDate(selectedDates!.end),
        'daysRequested': days,
        'pricePerDay': widget.pricePerDay,
        'subtotal': subtotal,
        'vat': vat,
        'total': total,
        'message': _messageController.text.trim(),
        'paymentMethod': paymentMethod,
        'status': 'pending',
        'createdAt': Timestamp.fromDate(now),
      };

      final docRef = await FirebaseFirestore.instance.collection('rentalRequests').add(rentalData);

      await FirebaseFirestore.instance.collection('notifications').add({
        'userId': widget.ownerId,
        'title': 'Nueva solicitud de renta',
        'message': 'Has recibido una nueva solicitud para tu producto.',
        'requestId': docRef.id,
        'type': 'rental_request',
        'read': false,
        'createdAt': Timestamp.now(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ Solicitud enviada')));
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al enviar: $e')));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          padding: const EdgeInsets.all(24),
          color: const Color(0xFF111111),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  'Seleccionar período de renta',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    final now = DateTime.now();
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: now,
                      lastDate: now.add(const Duration(days: 365)),
                      builder: (context, child) => Theme(
                        data: ThemeData.dark(),
                        child: child!,
                      ),
                    );
                    if (picked != null) {
                      setState(() => selectedDates = picked);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF222222),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    selectedDates == null
                        ? 'Seleccionar fechas'
                        : '${DateFormat('dd/MM/yyyy').format(selectedDates!.start)} - ${DateFormat('dd/MM/yyyy').format(selectedDates!.end)}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Método de pago',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: paymentMethod,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF222222),
                    border: OutlineInputBorder(),
                  ),
                  dropdownColor: const Color(0xFF222222),
                  style: const TextStyle(color: Colors.white),
                  items: const [
                    DropdownMenuItem(value: 'Transfer', child: Text('Transferencia')),
                    DropdownMenuItem(value: 'Cash', child: Text('Efectivo')),
                    DropdownMenuItem(value: 'Mobile', child: Text('Pago móvil')),
                  ],
                  onChanged: (v) => setState(() => paymentMethod = v!),
                ),
                const SizedBox(height: 24),

                const Text(
                  'Mensaje (opcional)',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _messageController,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF222222),
                    border: OutlineInputBorder(),
                    hintText: 'Escribe un mensaje para el dueño...',
                    hintStyle: TextStyle(color: Colors.white38),
                  ),
                ),
                const SizedBox(height: 24),

                if (selectedDates != null) ...[
                  Text('🗓 Días: $days', style: const TextStyle(color: Colors.white)),
                  Text('💰 Subtotal: \$${subtotal.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
                  Text('🧾 IVA (16%): \$${vat.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
                  Text('💸 Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 24),
                ],

                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0085FF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                      : const Text(
                    'Enviar solicitud',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white, fontWeight: bold ? FontWeight.bold : FontWeight.w400)),
          Text(value, style: TextStyle(color: Colors.white70, fontWeight: bold ? FontWeight.bold : FontWeight.w400)),
        ],
      ),
    );
  }