enum PaymentStatus {
  unpaid,
  pending,
  paid,
  refunded,
  unknown;

  static PaymentStatus fromServer(Object? value) => switch (value) {
    'UNPAID' => PaymentStatus.unpaid,
    'PENDING' => PaymentStatus.pending,
    'PAID' => PaymentStatus.paid,
    'REFUNDED' => PaymentStatus.refunded,
    _ => PaymentStatus.unknown,
  };
}
