// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regular_dues_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegularDuesListModel _$RegularDuesListModelFromJson(
  Map<String, dynamic> json,
) => _RegularDuesListModel(
  regularDues: (json['regularDues'] as List<dynamic>)
      .map((e) => RegularDueModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RegularDuesListModelToJson(
  _RegularDuesListModel instance,
) => <String, dynamic>{'regularDues': instance.regularDues};
