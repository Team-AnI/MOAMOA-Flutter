import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement.freezed.dart';

enum SettlementStatus { inProgress, completed, canceled, unknown }

enum PaymentStatus { unpaid, pending, paid, refunded, unknown }

@freezed
abstract class Settlement with _$Settlement {
  const factory Settlement({
    required int id,
    required String title,
    int? scheduleId,
    required int totalAmount,
    required int memberCount,
    required DateTime dueAt,
    required DateTime createdAt,
    required SettlementStatus status,
    DateTime? canceledAt,
    int? myAmount,
    PaymentStatus? myPaymentStatus,
    DateTime? myConfirmedAt,
  }) = _Settlement;
}

@freezed
abstract class SettlementPayment with _$SettlementPayment {
  const factory SettlementPayment({
    required int id,
    required int amount,
    required PaymentStatus status,
    int? memberId,
    String? userName,
    DateTime? submittedAt,
    DateTime? refundedAt,
  }) = _SettlementPayment;
}

@freezed
abstract class SettlementSummary with _$SettlementSummary {
  const factory SettlementSummary({
    required int totalCount,
    required int unpaidCount,
    required int pendingCount,
    required int paidCount,
    required int refundedCount,
    required int paidAmount,
  }) = _SettlementSummary;
}

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

@freezed
abstract class CreateSettlementInput with _$CreateSettlementInput {
  const factory CreateSettlementInput({
    required int meetingId,
    int? scheduleId,
    required String title,
    required int totalAmount,
    required List<int> memberIds,
    required String bankName,
    required String accountNumber,
    required String accountHolder,
    required DateTime dueAt,
    @Default(false) bool postNotice,
    int? replacesSettlementId,
  }) = _CreateSettlementInput;
}

@freezed
abstract class PaymentAction with _$PaymentAction {
  const factory PaymentAction({
    required int paymentId,
    required PaymentStatus status,
    DateTime? submittedAt,
    DateTime? confirmedAt,
    String? rejectionReason,
  }) = _PaymentAction;
}
