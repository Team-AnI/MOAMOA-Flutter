// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementDetailModel _$SettlementDetailModelFromJson(
  Map<String, dynamic> json,
) => _SettlementDetailModel(
  settlementId: (json['settlementId'] as num).toInt(),
  title: json['title'] as String,
  scheduleId: (json['scheduleId'] as num?)?.toInt(),
  scheduleTitle: json['scheduleTitle'] as String?,
  scheduleStartAt: json['scheduleStartAt'] == null
      ? null
      : DateTime.parse(json['scheduleStartAt'] as String),
  totalAmount: (json['totalAmount'] as num).toInt(),
  bankName: json['bankName'] as String,
  accountNumber: json['accountNumber'] as String,
  accountHolder: json['accountHolder'] as String,
  dueAt: DateTime.parse(json['dueAt'] as String),
  status: json['status'] as String,
  noticeId: (json['noticeId'] as num?)?.toInt(),
  canceledAt: json['canceledAt'] == null
      ? null
      : DateTime.parse(json['canceledAt'] as String),
  cancelReason: json['cancelReason'] as String?,
  replacesSettlementId: (json['replacesSettlementId'] as num?)?.toInt(),
  replacedBySettlementId: (json['replacedBySettlementId'] as num?)?.toInt(),
  myPayment: json['myPayment'] == null
      ? null
      : SettlementPaymentModel.fromJson(
          json['myPayment'] as Map<String, dynamic>,
        ),
  summary: SettlementSummaryModel.fromJson(
    json['summary'] as Map<String, dynamic>,
  ),
  payments:
      (json['payments'] as List<dynamic>?)
          ?.map(
            (e) => SettlementPaymentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <SettlementPaymentModel>[],
);

Map<String, dynamic> _$SettlementDetailModelToJson(
  _SettlementDetailModel instance,
) => <String, dynamic>{
  'settlementId': instance.settlementId,
  'title': instance.title,
  'scheduleId': instance.scheduleId,
  'scheduleTitle': instance.scheduleTitle,
  'scheduleStartAt': instance.scheduleStartAt?.toIso8601String(),
  'totalAmount': instance.totalAmount,
  'bankName': instance.bankName,
  'accountNumber': instance.accountNumber,
  'accountHolder': instance.accountHolder,
  'dueAt': instance.dueAt.toIso8601String(),
  'status': instance.status,
  'noticeId': instance.noticeId,
  'canceledAt': instance.canceledAt?.toIso8601String(),
  'cancelReason': instance.cancelReason,
  'replacesSettlementId': instance.replacesSettlementId,
  'replacedBySettlementId': instance.replacedBySettlementId,
  'myPayment': instance.myPayment,
  'summary': instance.summary,
  'payments': instance.payments,
};
