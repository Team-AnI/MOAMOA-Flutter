// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementPaymentRequest _$SettlementPaymentRequestFromJson(
  Map<String, dynamic> json,
) => _SettlementPaymentRequest(
  meetingId: (json['meetingId'] as num).toInt(),
  settlementId: (json['settlementId'] as num).toInt(),
  paymentId: (json['paymentId'] as num?)?.toInt(),
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$SettlementPaymentRequestToJson(
  _SettlementPaymentRequest instance,
) => <String, dynamic>{'reason': ?instance.reason};
