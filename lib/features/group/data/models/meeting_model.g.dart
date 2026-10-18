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
      role: MeetingModel._role(json['myRole']),
      memberCount: MeetingModel._memberCount(json['memberCount']),
    );

Map<String, dynamic> _$MeetingModelToJson(_MeetingModel instance) =>
    <String, dynamic>{
      'meetingId': instance.id,
      'name': instance.name,
      'description': instance.description,
      'myRole': MeetingModel._roleJson(instance.role),
      'memberCount': instance.memberCount,
    };
