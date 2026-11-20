// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementListModel _$SettlementListModelFromJson(Map<String, dynamic> json) =>
    _SettlementListModel(
      settlements: (json['settlements'] as List<dynamic>)
          .map((e) => SettlementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SettlementListModelToJson(
  _SettlementListModel instance,
) => <String, dynamic>{'settlements': instance.settlements};
