// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_vote_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateVoteRequest _$CreateVoteRequestFromJson(Map<String, dynamic> json) =>
    _CreateVoteRequest(
      meetingId: (json['meetingId'] as num).toInt(),
      title: json['title'] as String,
      voteDeadlineAt: json['voteDeadlineAt'] as String,
      meetingTimes: (json['meetingTimes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CreateVoteRequestToJson(_CreateVoteRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'voteDeadlineAt': instance.voteDeadlineAt,
      'meetingTimes': instance.meetingTimes,
    };
