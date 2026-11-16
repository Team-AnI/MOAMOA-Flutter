// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_my_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateMyProfileRequest _$UpdateMyProfileRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateMyProfileRequest(
  name: json['name'] as String,
  phone: json['phone'] as String?,
  profileColor: json['profileColor'] as String,
);

Map<String, dynamic> _$UpdateMyProfileRequestToJson(
  _UpdateMyProfileRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'profileColor': instance.profileColor,
};
