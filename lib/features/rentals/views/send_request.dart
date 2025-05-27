import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SendRequestPage extends StatefulWidget {
  final String productId;
  final String ownerId;
  final double pricePerDay;

  const SendRequestPage({
    super.key,
    required this.productId,
    required this.ownerId,
    required this.pricePerDay,
  });

  @override
  State<SendRequestPage> createState() => _SendRequestPageState();
}

class _SendRequestPageState extends State<SendRequestPage> {
  DateTimeRange? selectedDates;
  String paymentMethod = 'Transfer';
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int get days => selectedDates?.duration.inDays ?? 0;
  double get subtotal => widget.pricePerDay * days;
  double get vat => subtotal * 0.16;
  double get total => subtotal + vat;

  Future<void> _submitRequest() async {
    if (!_formKey.currentState!.validate() || selectedDates == null) return;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in first')),
      );
      return;
    }

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
      'read': false,
      'createdAt': Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('✅ Request submitted')));
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        elevation: 0,
        title: const Text('Request Rental'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Select rental period', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2C2C2C)),
                onPressed: () async {
                  final now = DateTime.now();
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: now,
                    lastDate: now.add(const Duration(days: 365)),
                  );
                  if (picked != null) setState(() => selectedDates = picked);
                },
                icon: const Icon(Icons.calendar_today, color: Colors.white),
                label: Text(
                  selectedDates == null
                      ? 'Select dates'
                      : '${DateFormat('MMM d').format(selectedDates!.start)} → ${DateFormat('MMM d, yyyy').format(selectedDates!.end)}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),

              const Text('Payment Method', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF2C2C2C),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(border: UnderlineInputBorder(), labelStyle: TextStyle(color: Colors.white)),
                value: paymentMethod,
                items: ['Transfer', 'Mobile Payment', 'Zelle', 'Cash']
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (value) => setState(() => paymentMethod = value!),
              ),
              const SizedBox(height: 24),

              const Text('What will you use it for?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _messageController,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Describe your usage...',
                  hintStyle: TextStyle(color: Colors.white54),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                ),
                validator: (value) => value == null || value.trim().length < 5 ? 'Required' : null,
              ),
              const SizedBox(height: 32),

              const Text('Rental Summary', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _summaryRow('Rental Days', '$days days'),
              _summaryRow('Daily Price', '\$${widget.pricePerDay.toStringAsFixed(2)}'),
              _summaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
              _summaryRow('VAT (16%)', '\$${vat.toStringAsFixed(2)}'),
              const Divider(color: Colors.white24),
              _summaryRow('Total Price', '\$${total.toStringAsFixed(2)}', bold: true),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0085FF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  icon: const Icon(Icons.send, color: Colors.white),
                  label: const Text('Submit Request', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  onPressed: _submitRequest,
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
