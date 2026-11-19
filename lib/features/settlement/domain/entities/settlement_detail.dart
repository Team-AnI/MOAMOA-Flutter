import 'package:freezed_annotation/freezed_annotation.dart';

import 'settlement_payment.dart';
import 'settlement_summary.dart';
import 'settlement_status.dart';
part 'settlement_detail.freezed.dart';

@freezed
abstract class SettlementDetail with _$SettlementDetail {
  const factory SettlementDetail({
    required int id,
    required String title,
    int? scheduleId,
    String? scheduleTitle,
    DateTime? scheduleStartAt,
    required int totalAmount,
    required String bankName,
    required String accountNumber,
    required String accountHolder,
    required DateTime dueAt,
    required SettlementStatus status,
    int? noticeId,
    DateTime? canceledAt,
    String? cancelReason,
    int? replacesSettlementId,
    int? replacedBySettlementId,
    SettlementPayment? myPayment,
    required SettlementSummary summary,
    required List<SettlementPayment> payments,
  }) = _SettlementDetail;
}
