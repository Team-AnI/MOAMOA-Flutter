enum SettlementStatus {
  inProgress,
  completed,
  canceled,
  unknown;

  static SettlementStatus fromServer(Object? value) => switch (value) {
    'IN_PROGRESS' => SettlementStatus.inProgress,
    'COMPLETED' => SettlementStatus.completed,
    'CANCELED' => SettlementStatus.canceled,
    _ => SettlementStatus.unknown,
  };
}
