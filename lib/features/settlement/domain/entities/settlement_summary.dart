import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_summary.freezed.dart';

@freezed
abstract class SettlementSummary with _$SettlementSummary {
  const factory SettlementSummary({
    required int totalCount,
    required int unpaidCount,
    required int pendingCount,
    required int paidCount,
    int? refundedCount,
    required int paidAmount,
  }) = _SettlementSummary;
}
