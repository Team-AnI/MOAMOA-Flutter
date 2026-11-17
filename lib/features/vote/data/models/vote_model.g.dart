// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VoteModel _$VoteModelFromJson(Map<String, dynamic> json) => _VoteModel(
  scheduleId: (json['scheduleId'] as num).toInt(),
  title: json['title'] as String,
  status: json['status'] as String,
  voteDeadlineAt: json['voteDeadlineAt'] as String,
  votingOpen: json['votingOpen'] as bool,
  memberCount: (json['memberCount'] as num).toInt(),
  respondedCount: (json['respondedCount'] as num).toInt(),
  myResponded: json['myResponded'] as bool,
  candidates: (json['candidates'] as List<dynamic>)
      .map((e) => VoteCandidateModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VoteModelToJson(_VoteModel instance) =>
    <String, dynamic>{
      'scheduleId': instance.scheduleId,
      'title': instance.title,
      'status': instance.status,
      'voteDeadlineAt': instance.voteDeadlineAt,
      'votingOpen': instance.votingOpen,
      'memberCount': instance.memberCount,
      'respondedCount': instance.respondedCount,
      'myResponded': instance.myResponded,
      'candidates': instance.candidates,
    };
