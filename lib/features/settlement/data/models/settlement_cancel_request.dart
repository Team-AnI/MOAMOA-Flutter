import 'package:freezed_annotation/freezed_annotation.dart';
part 'settlement_cancel_request.freezed.dart';
part 'settlement_cancel_request.g.dart';

@freezed
abstract class SettlementCancelRequest with _$SettlementCancelRequest {
  const factory SettlementCancelRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    @JsonKey(includeToJson: false) required int settlementId,
    @JsonKey(includeIfNull: false) String? reason,
  }) = _SettlementCancelRequest;
  factory SettlementCancelRequest.fromJson(Map<String, dynamic> json) =>
      _$SettlementCancelRequestFromJson(json);
}
