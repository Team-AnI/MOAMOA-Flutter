// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PasswordResetRequest _$PasswordResetRequestFromJson(
  Map<String, dynamic> json,
) => _PasswordResetRequest(
  token: json['token'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$PasswordResetRequestToJson(
  _PasswordResetRequest instance,
) => <String, dynamic>{
  'token': instance.token,
  'newPassword': instance.newPassword,
};
