// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_cancel_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementCancelRequest _$SettlementCancelRequestFromJson(
  Map<String, dynamic> json,
) => _SettlementCancelRequest(
  meetingId: (json['meetingId'] as num).toInt(),
  settlementId: (json['settlementId'] as num).toInt(),
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$SettlementCancelRequestToJson(
  _SettlementCancelRequest instance,
) => <String, dynamic>{'reason': ?instance.reason};
