// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_my_vote_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubmitMyVoteRequest _$SubmitMyVoteRequestFromJson(Map<String, dynamic> json) =>
    _SubmitMyVoteRequest(
      meetingId: (json['meetingId'] as num).toInt(),
      scheduleId: (json['scheduleId'] as num).toInt(),
      meetingTimes: (json['meetingTimes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SubmitMyVoteRequestToJson(
  _SubmitMyVoteRequest instance,
) => <String, dynamic>{'meetingTimes': instance.meetingTimes};
