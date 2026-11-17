// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_schedule_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConfirmScheduleRequest _$ConfirmScheduleRequestFromJson(
  Map<String, dynamic> json,
) => _ConfirmScheduleRequest(
  meetingId: (json['meetingId'] as num).toInt(),
  scheduleId: (json['scheduleId'] as num).toInt(),
  meetingTime: json['meetingTime'] as String,
);

Map<String, dynamic> _$ConfirmScheduleRequestToJson(
  _ConfirmScheduleRequest instance,
) => <String, dynamic>{'meetingTime': instance.meetingTime};
