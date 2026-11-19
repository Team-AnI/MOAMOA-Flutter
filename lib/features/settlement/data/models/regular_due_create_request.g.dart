// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regular_due_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegularDueCreateRequest _$RegularDueCreateRequestFromJson(
  Map<String, dynamic> json,
) => _RegularDueCreateRequest(
  meetingId: (json['meetingId'] as num).toInt(),
  title: json['title'] as String,
  amount: (json['amount'] as num).toInt(),
  cycleType: json['cycleType'] as String,
  cycleDay: json['cycleDay'] as String,
  sendTime: json['sendTime'] as String,
  dueDays: (json['dueDays'] as num).toInt(),
  bankName: json['bankName'] as String,
  accountNumber: json['accountNumber'] as String,
  accountHolder: json['accountHolder'] as String,
  postNotice: json['postNotice'] as bool,
);

Map<String, dynamic> _$RegularDueCreateRequestToJson(
  _RegularDueCreateRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'amount': instance.amount,
  'cycleType': instance.cycleType,
  'cycleDay': instance.cycleDay,
  'sendTime': instance.sendTime,
  'dueDays': instance.dueDays,
  'bankName': instance.bankName,
  'accountNumber': instance.accountNumber,
  'accountHolder': instance.accountHolder,
  'postNotice': instance.postNotice,
};
