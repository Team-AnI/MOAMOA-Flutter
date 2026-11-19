// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regular_due_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegularDueUpdateRequest _$RegularDueUpdateRequestFromJson(
  Map<String, dynamic> json,
) => _RegularDueUpdateRequest(
  meetingId: (json['meetingId'] as num).toInt(),
  regularDuesId: (json['regularDuesId'] as num).toInt(),
  title: json['title'] as String?,
  amount: (json['amount'] as num?)?.toInt(),
  cycleType: json['cycleType'] as String?,
  cycleDay: json['cycleDay'] as String?,
  sendTime: json['sendTime'] as String?,
  dueDays: (json['dueDays'] as num?)?.toInt(),
  bankName: json['bankName'] as String?,
  accountNumber: json['accountNumber'] as String?,
  accountHolder: json['accountHolder'] as String?,
  isActive: json['isActive'] as bool?,
  postNotice: json['postNotice'] as bool?,
  applyToCurrentSettlement: json['applyToCurrentSettlement'] as bool?,
);

Map<String, dynamic> _$RegularDueUpdateRequestToJson(
  _RegularDueUpdateRequest instance,
) => <String, dynamic>{
  'title': ?instance.title,
  'amount': ?instance.amount,
  'cycleType': ?instance.cycleType,
  'cycleDay': ?instance.cycleDay,
  'sendTime': ?instance.sendTime,
  'dueDays': ?instance.dueDays,
  'bankName': ?instance.bankName,
  'accountNumber': ?instance.accountNumber,
  'accountHolder': ?instance.accountHolder,
  'isActive': ?instance.isActive,
  'postNotice': ?instance.postNotice,
  'applyToCurrentSettlement': ?instance.applyToCurrentSettlement,
};
