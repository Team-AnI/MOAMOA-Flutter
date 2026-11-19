import 'package:freezed_annotation/freezed_annotation.dart';

import 'payment_status.dart';
part 'settlement_payment.freezed.dart';

@freezed
abstract class SettlementPayment with _$SettlementPayment {
  const factory SettlementPayment({
    required int id,
    required int amount,
    required PaymentStatus status,
    int? memberId,
    String? userName,
    DateTime? submittedAt,
    DateTime? refundedAt,
  }) = _SettlementPayment;
}
