// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_notices_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FetchNoticesRequest _$FetchNoticesRequestFromJson(Map<String, dynamic> json) =>
    _FetchNoticesRequest(
      meetingId: (json['meetingId'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$FetchNoticesRequestToJson(
  _FetchNoticesRequest instance,
) => <String, dynamic>{'page': instance.page, 'size': instance.size};
