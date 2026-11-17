// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_candidate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VoteCandidateModel _$VoteCandidateModelFromJson(Map<String, dynamic> json) =>
    _VoteCandidateModel(
      meetingTime: json['meetingTime'] as String,
      availableCount: (json['availableCount'] as num).toInt(),
      selectedByMe: json['selectedByMe'] as bool,
    );

Map<String, dynamic> _$VoteCandidateModelToJson(_VoteCandidateModel instance) =>
    <String, dynamic>{
      'meetingTime': instance.meetingTime,
      'availableCount': instance.availableCount,
      'selectedByMe': instance.selectedByMe,
    };
