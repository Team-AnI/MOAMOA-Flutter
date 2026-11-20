import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_create_request.freezed.dart';
part 'settlement_create_request.g.dart';

@freezed
abstract class SettlementCreateRequest with _$SettlementCreateRequest {
  const factory SettlementCreateRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    @JsonKey(includeIfNull: false) int? scheduleId,
    required String title,
    required int totalAmount,
    required List<int> memberIds,
    required String bankName,
    required String accountNumber,
    required String accountHolder,
    required DateTime dueAt,
    required bool postNotice,
    @JsonKey(includeIfNull: false) int? replacesSettlementId,
  }) = _SettlementCreateRequest;
  factory SettlementCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$SettlementCreateRequestFromJson(json);
}
