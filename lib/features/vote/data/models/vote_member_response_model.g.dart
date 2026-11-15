// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_member_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VoteMemberResponseModel _$VoteMemberResponseModelFromJson(
  Map<String, dynamic> json,
) => _VoteMemberResponseModel(
  memberId: (json['memberId'] as num).toInt(),
  userName: _readUserName(json, 'userName') as String?,
  responded: json['responded'] as bool,
  submittedAt: json['submittedAt'] as String?,
);

Map<String, dynamic> _$VoteMemberResponseModelToJson(
  _VoteMemberResponseModel instance,
) => <String, dynamic>{
  'memberId': instance.memberId,
  'userName': instance.userName,
  'responded': instance.responded,
  'submittedAt': instance.submittedAt,
};
