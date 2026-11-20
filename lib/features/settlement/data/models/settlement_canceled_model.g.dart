// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_canceled_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementCanceledModel _$SettlementCanceledModelFromJson(
  Map<String, dynamic> json,
) => _SettlementCanceledModel(
  settlementId: (json['settlementId'] as num).toInt(),
  status: json['status'] as String,
);

Map<String, dynamic> _$SettlementCanceledModelToJson(
  _SettlementCanceledModel instance,
) => <String, dynamic>{
  'settlementId': instance.settlementId,
  'status': instance.status,
};
