import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:renty/models/product_model.dart';
import 'package:renty/models/rental_model.dart';
import 'package:renty/services/rental_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RequestRentalPage extends StatefulWidget {
  final ProductModel product;

  const RequestRentalPage({super.key, required this.product});

  @override
  State<RequestRentalPage> createState() => _RequestRentalPageState();
}

class _RequestRentalPageState extends State<RequestRentalPage> {
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isSubmitting = false;

  double getTotalPrice() {
    if (_startDate == null || _endDate == null) return 0.0;
    final days = _endDate!.difference(_startDate!).inDays + 1;
    return days * widget.product.pricePerDay;
  }

  void _submitRental() async {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona fechas válidas')),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isSubmitting = true);

    final rental = RentalModel(
      rentalId: '', // será asignado por Firestore
      itemId: widget.product.productId,
      renterId: user.uid,
      ownerId: widget.product.ownerId,
      startDate: _startDate!,
      endDate: _endDate!,
      totalPrice: getTotalPrice(),
      status: 'pending',
      reviewedByRenter: false,
      reviewedByOwner: false,
      createdAt: DateTime.now(),
    );

    try {
      final docRef = FirebaseFirestore.instance.collection('rentals').doc();
      await docRef.set(rental.copyWith(rentalId: docRef.id).toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Solicitud enviada correctamente')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  Future<void> _selectDate({required bool isStart}) async {
    final now = DateTime.now();
    final initial = isStart ? now : (_startDate ?? now).add(const Duration(days: 1));

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(picked)) {
            _endDate = picked.add(const Duration(days: 1));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Solicitar alquiler')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.product.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(widget.product.description),
            const SizedBox(height: 20),
            Text('Precio por día: \$${widget.product.pricePerDay.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(isStart: true),
                    child: Text(_startDate == null
                        ? 'Fecha inicio'
                        : 'Inicio: ${_startDate!.toLocal().toString().split(' ')[0]}'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(isStart: false),
                    child: Text(_endDate == null
                        ? 'Fecha fin'
                        : 'Fin: ${_endDate!.toLocal().toString().split(' ')[0]}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Total: \$${getTotalPrice().toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitRental,
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Enviar solicitud'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
