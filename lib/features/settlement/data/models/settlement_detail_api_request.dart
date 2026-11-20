import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_detail_api_request.freezed.dart';
part 'settlement_detail_api_request.g.dart';

@freezed
abstract class SettlementDetailApiRequest with _$SettlementDetailApiRequest {
  const factory SettlementDetailApiRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    @JsonKey(includeToJson: false) required int settlementId,
  }) = _SettlementDetailApiRequest;
  factory SettlementDetailApiRequest.fromJson(Map<String, dynamic> json) =>
      _$SettlementDetailApiRequestFromJson(json);
}
