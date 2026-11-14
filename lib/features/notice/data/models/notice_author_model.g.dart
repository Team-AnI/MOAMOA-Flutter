// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_author_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoticeAuthorModel _$NoticeAuthorModelFromJson(Map<String, dynamic> json) =>
    _NoticeAuthorModel(
      memberId: (json['memberId'] as num).toInt(),
      userName: json['userName'] as String?,
      profileColor: json['profileColor'] as String?,
    );

Map<String, dynamic> _$NoticeAuthorModelToJson(_NoticeAuthorModel instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'userName': instance.userName,
      'profileColor': instance.profileColor,
    };
