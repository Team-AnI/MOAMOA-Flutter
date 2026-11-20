import 'package:freezed_annotation/freezed_annotation.dart';

part 'regular_due_update_request.freezed.dart';
part 'regular_due_update_request.g.dart';

@freezed
abstract class RegularDueUpdateRequest with _$RegularDueUpdateRequest {
  const factory RegularDueUpdateRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    @JsonKey(includeToJson: false) required int regularDuesId,
    @JsonKey(includeIfNull: false) String? title,
    @JsonKey(includeIfNull: false) int? amount,
    @JsonKey(includeIfNull: false) String? cycleType,
    @JsonKey(includeIfNull: false) String? cycleDay,
    @JsonKey(includeIfNull: false) String? sendTime,
    @JsonKey(includeIfNull: false) int? dueDays,
    @JsonKey(includeIfNull: false) String? bankName,
    @JsonKey(includeIfNull: false) String? accountNumber,
    @JsonKey(includeIfNull: false) String? accountHolder,
    @JsonKey(includeIfNull: false) bool? isActive,
    @JsonKey(includeIfNull: false) bool? postNotice,
    @JsonKey(includeIfNull: false) bool? applyToCurrentSettlement,
  }) = _RegularDueUpdateRequest;
  factory RegularDueUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$RegularDueUpdateRequestFromJson(json);
}
