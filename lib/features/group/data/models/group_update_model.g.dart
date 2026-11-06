// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupUpdateModel _$GroupUpdateModelFromJson(Map<String, dynamic> json) =>
    _GroupUpdateModel(
      meetingId: (json['meetingId'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$GroupUpdateModelToJson(_GroupUpdateModel instance) =>
    <String, dynamic>{
      'meetingId': instance.meetingId,
      'name': instance.name,
      'description': instance.description,
    };
