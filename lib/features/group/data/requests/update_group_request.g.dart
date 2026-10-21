// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateGroupRequest _$UpdateGroupRequestFromJson(Map<String, dynamic> json) =>
    _UpdateGroupRequest(
      meetingId: (json['meetingId'] as num).toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$UpdateGroupRequestToJson(_UpdateGroupRequest instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'description': ?instance.description,
    };
