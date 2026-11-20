import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_list_request.freezed.dart';
part 'settlement_list_request.g.dart';

@freezed
abstract class SettlementListRequest with _$SettlementListRequest {
  const factory SettlementListRequest({
    @JsonKey(includeToJson: false) required int meetingId,
  }) = _SettlementListRequest;
  factory SettlementListRequest.fromJson(Map<String, dynamic> json) =>
      _$SettlementListRequestFromJson(json);
}
