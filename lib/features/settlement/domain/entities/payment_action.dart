import 'package:freezed_annotation/freezed_annotation.dart';

import 'payment_status.dart';

part 'payment_action.freezed.dart';

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
