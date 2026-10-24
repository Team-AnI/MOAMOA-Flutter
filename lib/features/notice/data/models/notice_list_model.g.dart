// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoticeListModel _$NoticeListModelFromJson(Map<String, dynamic> json) =>
    _NoticeListModel(
      notices: (json['notices'] as List<dynamic>)
          .map((e) => NoticeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
    );

Map<String, dynamic> _$NoticeListModelToJson(_NoticeListModel instance) =>
    <String, dynamic>{
      'notices': instance.notices,
      'page': instance.page,
      'size': instance.size,
      'hasNext': instance.hasNext,
    };
