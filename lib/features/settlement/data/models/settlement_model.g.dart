// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementModel _$SettlementModelFromJson(Map<String, dynamic> json) =>
    _SettlementModel(
      settlementId: (json['settlementId'] as num).toInt(),
      title: json['title'] as String,
      scheduleId: (json['scheduleId'] as num?)?.toInt(),
      totalAmount: (json['totalAmount'] as num).toInt(),
      memberCount: (json['memberCount'] as num).toInt(),
      dueAt: DateTime.parse(json['dueAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String,
      canceledAt: json['canceledAt'] == null
          ? null
          : DateTime.parse(json['canceledAt'] as String),
      myAmount: (json['myAmount'] as num?)?.toInt(),
      myPaymentStatus: json['myPaymentStatus'] as String?,
      myConfirmedAt: json['myConfirmedAt'] == null
          ? null
          : DateTime.parse(json['myConfirmedAt'] as String),
    );

Map<String, dynamic> _$SettlementModelToJson(_SettlementModel instance) =>
    <String, dynamic>{
      'settlementId': instance.settlementId,
      'title': instance.title,
      'scheduleId': instance.scheduleId,
      'totalAmount': instance.totalAmount,
      'memberCount': instance.memberCount,
      'dueAt': instance.dueAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'status': instance.status,
      'canceledAt': instance.canceledAt?.toIso8601String(),
      'myAmount': instance.myAmount,
      'myPaymentStatus': instance.myPaymentStatus,
      'myConfirmedAt': instance.myConfirmedAt?.toIso8601String(),
    };
