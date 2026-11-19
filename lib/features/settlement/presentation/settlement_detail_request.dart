import 'package:freezed_annotation/freezed_annotation.dart';
part 'settlement_detail_request.freezed.dart';

@freezed
abstract class SettlementDetailRequest with _$SettlementDetailRequest {
  const factory SettlementDetailRequest({
    required int meetingId,
    required int settlementId,
  }) = _SettlementDetailRequest;
}
