// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MyAccountModel _$MyAccountModelFromJson(Map<String, dynamic> json) =>
    _MyAccountModel(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      profileColor: json['profileColor'] as String?,
    );

Map<String, dynamic> _$MyAccountModelToJson(_MyAccountModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'profileColor': instance.profileColor,
    };
