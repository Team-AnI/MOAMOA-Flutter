// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeetingModel _$MeetingModelFromJson(Map<String, dynamic> json) =>
    _MeetingModel(
      id: (json['meetingId'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      role: json['myRole'] as String,
      memberCount: json['memberCount'] as num?,
    );

Map<String, dynamic> _$MeetingModelToJson(_MeetingModel instance) =>
    <String, dynamic>{
      'meetingId': instance.id,
      'name': instance.name,
      'description': instance.description,
      'myRole': instance.role,
      'memberCount': instance.memberCount,
    };
