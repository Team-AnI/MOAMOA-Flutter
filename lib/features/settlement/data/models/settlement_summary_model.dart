import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_summary_model.freezed.dart';
part 'settlement_summary_model.g.dart';

@freezed
abstract class SettlementSummaryModel with _$SettlementSummaryModel {
  const factory SettlementSummaryModel({
    required int totalCount,
    required int unpaidCount,
    required int pendingCount,
    required int paidCount,
    int? refundedCount,
    required int paidAmount,
  }) = _SettlementSummaryModel;
  factory SettlementSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementSummaryModelFromJson(json);
}
