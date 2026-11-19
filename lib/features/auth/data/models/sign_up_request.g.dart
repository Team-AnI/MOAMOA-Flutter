// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) =>
    _SignUpRequest(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String?,
      agreedToTerms: json['agreedToTerms'] as bool,
    );

Map<String, dynamic> _$SignUpRequestToJson(_SignUpRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone': ?instance.phone,
      'agreedToTerms': instance.agreedToTerms,
    };
