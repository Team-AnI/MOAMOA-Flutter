import 'package:freezed_annotation/freezed_annotation.dart';

import 'settlement_payment_model.dart';
import 'settlement_summary_model.dart';

part 'settlement_detail_model.freezed.dart';
part 'settlement_detail_model.g.dart';

@freezed
abstract class SettlementDetailModel with _$SettlementDetailModel {
  const factory SettlementDetailModel({
    required int settlementId,
    required String title,
    int? scheduleId,
    String? scheduleTitle,
    DateTime? scheduleStartAt,
    required int totalAmount,
    required String bankName,
    required String accountNumber,
    required String accountHolder,
    required DateTime dueAt,
    required String status,
    int? noticeId,
    DateTime? canceledAt,
    String? cancelReason,
    int? replacesSettlementId,
    int? replacedBySettlementId,
    SettlementPaymentModel? myPayment,
    required SettlementSummaryModel summary,
    @Default(<SettlementPaymentModel>[]) List<SettlementPaymentModel> payments,
  }) = _SettlementDetailModel;
  factory SettlementDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementDetailModelFromJson(json);
}
