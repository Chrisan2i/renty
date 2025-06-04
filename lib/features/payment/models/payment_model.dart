class Payment {
  final String paymentId;         // ID único del pago
  final String rentalId;          // ID del alquiler asociado
  final String payerId;           // ID del usuario que paga (renter)
  final String payeeId;           // ID del usuario que recibe (owner)
  final double amount;            // Monto total
  final String currency;          // Moneda (ej. "USD")
  final String status;            // Estado: pending | completed | failed | refunded
  final DateTime createdAt;       // Fecha de creación del pago
  final DateTime? completedAt;    // Fecha en que se completó
  final String method;            // Método de pago: wallet | card | transfer
  final String? transactionRef;   // Referencia externa (Stripe, banco, etc.)
  final String? notes;            // Notas adicionales si aplica

  Payment({
    required this.paymentId,
    required this.rentalId,
    required this.payerId,
    required this.payeeId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.createdAt,
    this.completedAt,
    required this.method,
    this.transactionRef,
    this.notes,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json['paymentId'],
      rentalId: json['rentalId'],
      payerId: json['payerId'],
      payeeId: json['payeeId'],
      amount: json['amount'],
      currency: json['currency'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
      method: json['method'],
      transactionRef: json['transactionRef'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'rentalId': rentalId,
      'payerId': payerId,
      'payeeId': payeeId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'method': method,
      'transactionRef': transactionRef,
      'notes': notes,
    };
  }
}