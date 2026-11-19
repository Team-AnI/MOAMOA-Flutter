// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementCreateRequest _$SettlementCreateRequestFromJson(
  Map<String, dynamic> json,
) => _SettlementCreateRequest(
  meetingId: (json['meetingId'] as num).toInt(),
  scheduleId: (json['scheduleId'] as num?)?.toInt(),
  title: json['title'] as String,
  totalAmount: (json['totalAmount'] as num).toInt(),
  memberIds: (json['memberIds'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  bankName: json['bankName'] as String,
  accountNumber: json['accountNumber'] as String,
  accountHolder: json['accountHolder'] as String,
  dueAt: DateTime.parse(json['dueAt'] as String),
  postNotice: json['postNotice'] as bool,
  replacesSettlementId: (json['replacesSettlementId'] as num?)?.toInt(),
);

Map<String, dynamic> _$SettlementCreateRequestToJson(
  _SettlementCreateRequest instance,
) => <String, dynamic>{
  'scheduleId': ?instance.scheduleId,
  'title': instance.title,
  'totalAmount': instance.totalAmount,
  'memberIds': instance.memberIds,
  'bankName': instance.bankName,
  'accountNumber': instance.accountNumber,
  'accountHolder': instance.accountHolder,
  'dueAt': instance.dueAt.toIso8601String(),
  'postNotice': instance.postNotice,
  'replacesSettlementId': ?instance.replacesSettlementId,
};
