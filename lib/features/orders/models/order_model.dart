class Order {
  final String orderId;               // ID único de la orden (puede ser el mismo que paymentId)
  final String paymentId;            // ID del pago relacionado
  final String requestId;            // ID de la solicitud original
  final String renterId;             // Usuario que alquila
  final String ownerId;              // Usuario dueño del producto
  final String productId;            // Producto alquilado
  final String status;               // Estado: pending | confirmed | rejected | cancelled
  final bool renterConfirmed;        // Confirmación del renter (sí recibió respuesta o no)
  final bool ownerConfirmed;         // Confirmación del owner (sí recibió el pago o no)
  final DateTime createdAt;          // Fecha de creación de la orden
  final DateTime? confirmedAt;       // Fecha en la que se confirmó (si aplica)
  final String? notes;               // Mensaje opcional o nota

  Order({
    required this.orderId,
    required this.paymentId,
    required this.requestId,
    required this.renterId,
    required this.ownerId,
    required this.productId,
    required this.status,
    required this.renterConfirmed,
    required this.ownerConfirmed,
    required this.createdAt,
    this.confirmedAt,
    this.notes,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      paymentId: json['paymentId'],
      requestId: json['requestId'],
      renterId: json['renterId'],
      ownerId: json['ownerId'],
      productId: json['productId'],
      status: json['status'],
      renterConfirmed: json['renterConfirmed'],
      ownerConfirmed: json['ownerConfirmed'],
      createdAt: DateTime.parse(json['createdAt']),
      confirmedAt: json['confirmedAt'] != null ? DateTime.parse(json['confirmedAt']) : null,
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'paymentId': paymentId,
      'requestId': requestId,
      'renterId': renterId,
      'ownerId': ownerId,
      'productId': productId,
      'status': status,
      'renterConfirmed': renterConfirmed,
      'ownerConfirmed': ownerConfirmed,
      'createdAt': createdAt.toIso8601String(),
      'confirmedAt': confirmedAt?.toIso8601String(),
      'notes': notes,
    };
  }
}