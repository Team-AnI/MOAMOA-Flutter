import 'package:freezed_annotation/freezed_annotation.dart';

import 'settlement_model.dart';

part 'settlement_list_model.freezed.dart';
part 'settlement_list_model.g.dart';

@freezed
abstract class SettlementListModel with _$SettlementListModel {
  const factory SettlementListModel({
    required List<SettlementModel> settlements,
  }) = _SettlementListModel;
  factory SettlementListModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementListModelFromJson(json);
}
