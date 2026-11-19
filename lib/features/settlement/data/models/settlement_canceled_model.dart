import 'package:freezed_annotation/freezed_annotation.dart';
part 'settlement_canceled_model.freezed.dart';
part 'settlement_canceled_model.g.dart';

@freezed
abstract class SettlementCanceledModel with _$SettlementCanceledModel {
  const factory SettlementCanceledModel({
    required int settlementId,
    required String status,
  }) = _SettlementCanceledModel;
  factory SettlementCanceledModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementCanceledModelFromJson(json);
}
