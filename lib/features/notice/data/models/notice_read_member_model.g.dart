// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_read_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoticeReadMemberModel _$NoticeReadMemberModelFromJson(
  Map<String, dynamic> json,
) => _NoticeReadMemberModel(
  memberId: (json['memberId'] as num).toInt(),
  userName: json['userName'] as String?,
  profileColor: json['profileColor'] as String?,
  readAt: json['readAt'] as String?,
);

Map<String, dynamic> _$NoticeReadMemberModelToJson(
  _NoticeReadMemberModel instance,
) => <String, dynamic>{
  'memberId': instance.memberId,
  'userName': instance.userName,
  'profileColor': instance.profileColor,
  'readAt': instance.readAt,
};
