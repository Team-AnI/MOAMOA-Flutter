// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementPaymentModel _$SettlementPaymentModelFromJson(
  Map<String, dynamic> json,
) => _SettlementPaymentModel(
  paymentId: (json['paymentId'] as num).toInt(),
  amount: (json['amount'] as num).toInt(),
  status: json['status'] as String,
  memberId: (json['memberId'] as num?)?.toInt(),
  userName: json['userName'] as String?,
  submittedAt: json['submittedAt'] == null
      ? null
      : DateTime.parse(json['submittedAt'] as String),
  refundedAt: json['refundedAt'] == null
      ? null
      : DateTime.parse(json['refundedAt'] as String),
);

Map<String, dynamic> _$SettlementPaymentModelToJson(
  _SettlementPaymentModel instance,
) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'amount': instance.amount,
  'status': instance.status,
  'memberId': instance.memberId,
  'userName': instance.userName,
  'submittedAt': instance.submittedAt?.toIso8601String(),
  'refundedAt': instance.refundedAt?.toIso8601String(),
};
