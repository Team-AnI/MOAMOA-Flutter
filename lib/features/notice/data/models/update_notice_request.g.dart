// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_notice_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateNoticeRequest _$UpdateNoticeRequestFromJson(Map<String, dynamic> json) =>
    _UpdateNoticeRequest(
      meetingId: (json['meetingId'] as num).toInt(),
      noticeId: (json['noticeId'] as num).toInt(),
      title: json['title'] as String?,
      content: json['content'] as String?,
      isImportant: json['isImportant'] as bool?,
    );

Map<String, dynamic> _$UpdateNoticeRequestToJson(
  _UpdateNoticeRequest instance,
) => <String, dynamic>{
  'title': ?instance.title,
  'content': ?instance.content,
  'isImportant': ?instance.isImportant,
};
