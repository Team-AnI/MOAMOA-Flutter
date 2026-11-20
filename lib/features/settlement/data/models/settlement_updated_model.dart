import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_updated_model.freezed.dart';
part 'settlement_updated_model.g.dart';

@freezed
abstract class SettlementUpdatedModel with _$SettlementUpdatedModel {
  const factory SettlementUpdatedModel({required int settlementId}) =
      _SettlementUpdatedModel;
  factory SettlementUpdatedModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementUpdatedModelFromJson(json);
}
