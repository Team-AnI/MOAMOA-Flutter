import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_create_model.freezed.dart';
part 'settlement_create_model.g.dart';

@freezed
abstract class SettlementCreateModel with _$SettlementCreateModel {
  const factory SettlementCreateModel({required int settlementId}) =
      _SettlementCreateModel;
  factory SettlementCreateModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementCreateModelFromJson(json);
}
