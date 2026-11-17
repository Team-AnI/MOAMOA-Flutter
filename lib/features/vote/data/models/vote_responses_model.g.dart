// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_responses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VoteResponsesModel _$VoteResponsesModelFromJson(Map<String, dynamic> json) =>
    _VoteResponsesModel(
      memberCount: (json['memberCount'] as num).toInt(),
      respondedCount: (json['respondedCount'] as num).toInt(),
      members: (json['members'] as List<dynamic>)
          .map(
            (e) => VoteMemberResponseModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$VoteResponsesModelToJson(_VoteResponsesModel instance) =>
    <String, dynamic>{
      'memberCount': instance.memberCount,
      'respondedCount': instance.respondedCount,
      'members': instance.members,
    };
