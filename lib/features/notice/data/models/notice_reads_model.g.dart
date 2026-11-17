// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_reads_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoticeReadsModel _$NoticeReadsModelFromJson(Map<String, dynamic> json) =>
    _NoticeReadsModel(
      readCount: (json['readCount'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      readMembers: (json['readMembers'] as List<dynamic>)
          .map((e) => NoticeReadMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      unreadMembers: (json['unreadMembers'] as List<dynamic>)
          .map((e) => NoticeReadMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NoticeReadsModelToJson(_NoticeReadsModel instance) =>
    <String, dynamic>{
      'readCount': instance.readCount,
      'totalCount': instance.totalCount,
      'readMembers': instance.readMembers,
      'unreadMembers': instance.unreadMembers,
    };
