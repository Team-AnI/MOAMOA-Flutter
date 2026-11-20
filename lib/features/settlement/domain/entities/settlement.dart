import 'package:freezed_annotation/freezed_annotation.dart';

import 'payment_status.dart';
import 'settlement_status.dart';

export 'create_settlement_input.dart';
export 'dues_cycle.dart';
export 'payment_action.dart';
export 'payment_status.dart';
export 'regular_due.dart';
export 'regular_due_input.dart';
export 'settlement_detail.dart';
export 'settlement_payment.dart';
export 'settlement_status.dart';
export 'settlement_summary.dart';

part 'settlement.freezed.dart';

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
