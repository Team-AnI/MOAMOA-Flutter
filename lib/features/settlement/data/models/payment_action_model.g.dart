// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_action_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentActionModel _$PaymentActionModelFromJson(Map<String, dynamic> json) =>
    _PaymentActionModel(
      paymentId: (json['paymentId'] as num).toInt(),
      status: json['status'] as String,
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      rejectionReason: json['rejectionReason'] as String?,
    );

Map<String, dynamic> _$PaymentActionModelToJson(_PaymentActionModel instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'status': instance.status,
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'rejectionReason': instance.rejectionReason,
    };
