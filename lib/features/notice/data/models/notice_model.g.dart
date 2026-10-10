// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoticeModel _$NoticeModelFromJson(Map<String, dynamic> json) => _NoticeModel(
  noticeId: (json['noticeId'] as num).toInt(),
  title: json['title'] as String,
  createdAt: json['createdAt'] as String,
  content: json['content'] as String?,
  authorNickname: json['authorNickname'] as String?,
  isPinned: json['isPinned'] as bool?,
  account: json['account'] == null
      ? null
      : NoticeAccountModel.fromJson(json['account'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NoticeModelToJson(_NoticeModel instance) =>
    <String, dynamic>{
      'noticeId': instance.noticeId,
      'title': instance.title,
      'createdAt': instance.createdAt,
      'content': instance.content,
      'authorNickname': instance.authorNickname,
      'isPinned': instance.isPinned,
      'account': instance.account,
    };
