// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoticeAccountModel _$NoticeAccountModelFromJson(Map<String, dynamic> json) =>
    _NoticeAccountModel(
      bankName: json['bankName'] as String,
      accountNumber: json['accountNumber'] as String,
      holderName: json['holderName'] as String,
    );

Map<String, dynamic> _$NoticeAccountModelToJson(_NoticeAccountModel instance) =>
    <String, dynamic>{
      'bankName': instance.bankName,
      'accountNumber': instance.accountNumber,
      'holderName': instance.holderName,
    };
