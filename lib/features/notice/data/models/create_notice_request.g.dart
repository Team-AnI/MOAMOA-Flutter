// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_notice_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateNoticeRequest _$CreateNoticeRequestFromJson(Map<String, dynamic> json) =>
    _CreateNoticeRequest(
      meetingId: (json['meetingId'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      isImportant: json['isImportant'] as bool? ?? false,
    );

Map<String, dynamic> _$CreateNoticeRequestToJson(
  _CreateNoticeRequest instance,
) => <String, dynamic>{
  'title': instance.title,
  'content': instance.content,
  'isImportant': instance.isImportant,
};
