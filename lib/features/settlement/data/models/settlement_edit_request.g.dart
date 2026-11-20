// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_edit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementEditRequest _$SettlementEditRequestFromJson(
  Map<String, dynamic> json,
) => _SettlementEditRequest(
  meetingId: (json['meetingId'] as num).toInt(),
  settlementId: (json['settlementId'] as num).toInt(),
  unlinkSchedule: json['unlinkSchedule'] as bool? ?? false,
  title: json['title'] as String?,
  totalAmount: (json['totalAmount'] as num?)?.toInt(),
  memberIds: (json['memberIds'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  bankName: json['bankName'] as String?,
  accountNumber: json['accountNumber'] as String?,
  accountHolder: json['accountHolder'] as String?,
  dueAt: json['dueAt'] == null ? null : DateTime.parse(json['dueAt'] as String),
);

Map<String, dynamic> _$SettlementEditRequestToJson(
  _SettlementEditRequest instance,
) => <String, dynamic>{
  'title': ?instance.title,
  'totalAmount': ?instance.totalAmount,
  'memberIds': ?instance.memberIds,
  'bankName': ?instance.bankName,
  'accountNumber': ?instance.accountNumber,
  'accountHolder': ?instance.accountHolder,
  'dueAt': ?instance.dueAt?.toIso8601String(),
};
