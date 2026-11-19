// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementSummaryModel _$SettlementSummaryModelFromJson(
  Map<String, dynamic> json,
) => _SettlementSummaryModel(
  totalCount: (json['totalCount'] as num).toInt(),
  unpaidCount: (json['unpaidCount'] as num).toInt(),
  pendingCount: (json['pendingCount'] as num).toInt(),
  paidCount: (json['paidCount'] as num).toInt(),
  refundedCount: (json['refundedCount'] as num?)?.toInt(),
  paidAmount: (json['paidAmount'] as num).toInt(),
);

Map<String, dynamic> _$SettlementSummaryModelToJson(
  _SettlementSummaryModel instance,
) => <String, dynamic>{
  'totalCount': instance.totalCount,
  'unpaidCount': instance.unpaidCount,
  'pendingCount': instance.pendingCount,
  'paidCount': instance.paidCount,
  'refundedCount': instance.refundedCount,
  'paidAmount': instance.paidAmount,
};
