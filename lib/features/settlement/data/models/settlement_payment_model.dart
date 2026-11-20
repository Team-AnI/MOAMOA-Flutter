import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/settlement.dart';

part 'settlement_payment_model.freezed.dart';
part 'settlement_payment_model.g.dart';

@freezed
abstract class SettlementPaymentModel with _$SettlementPaymentModel {
  const factory SettlementPaymentModel({
    required int paymentId,
    required int amount,
    required String status,
    int? memberId,
    String? userName,
    DateTime? submittedAt,
    DateTime? refundedAt,
  }) = _SettlementPaymentModel;
  factory SettlementPaymentModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementPaymentModelFromJson(json);
}

extension SettlementPaymentModelX on SettlementPaymentModel {
  SettlementPayment toEntity() => SettlementPayment(
    id: paymentId,
    amount: amount,
    status: PaymentStatus.fromServer(status),
    memberId: memberId,
    userName: userName,
    submittedAt: submittedAt,
    refundedAt: refundedAt,
  );
}
