// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScheduleResponse _$ScheduleResponseFromJson(Map<String, dynamic> json) =>
    _ScheduleResponse(
      id: (json['scheduleId'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: json['endAt'] == null
          ? null
          : DateTime.parse(json['endAt'] as String),
      location: json['location'] as String? ?? '',
    );

Map<String, dynamic> _$ScheduleResponseToJson(_ScheduleResponse instance) =>
    <String, dynamic>{
      'scheduleId': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt?.toIso8601String(),
      'location': instance.location,
    };
