import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_edit_request.freezed.dart';
part 'settlement_edit_request.g.dart';

@freezed
abstract class SettlementEditRequest with _$SettlementEditRequest {
  const SettlementEditRequest._();
  Map<String, dynamic> toPatchJson() => {
    ...toJson(),
    if (unlinkSchedule) 'scheduleId': null,
  };
  const factory SettlementEditRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    @JsonKey(includeToJson: false) required int settlementId,
    @JsonKey(includeToJson: false) @Default(false) bool unlinkSchedule,
    @JsonKey(includeIfNull: false) String? title,
    @JsonKey(includeIfNull: false) int? totalAmount,
    @JsonKey(includeIfNull: false) List<int>? memberIds,
    @JsonKey(includeIfNull: false) String? bankName,
    @JsonKey(includeIfNull: false) String? accountNumber,
    @JsonKey(includeIfNull: false) String? accountHolder,
    @JsonKey(includeIfNull: false) DateTime? dueAt,
  }) = _SettlementEditRequest;
  factory SettlementEditRequest.fromJson(Map<String, dynamic> json) =>
      _$SettlementEditRequestFromJson(json);
}
