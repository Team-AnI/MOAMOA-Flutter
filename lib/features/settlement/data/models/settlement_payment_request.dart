import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_payment_request.freezed.dart';
part 'settlement_payment_request.g.dart';

@freezed
abstract class SettlementPaymentRequest with _$SettlementPaymentRequest {
  const factory SettlementPaymentRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    @JsonKey(includeToJson: false) required int settlementId,
    @JsonKey(includeToJson: false) int? paymentId,
    @JsonKey(includeIfNull: false) String? reason,
  }) = _SettlementPaymentRequest;
  factory SettlementPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$SettlementPaymentRequestFromJson(json);
}
