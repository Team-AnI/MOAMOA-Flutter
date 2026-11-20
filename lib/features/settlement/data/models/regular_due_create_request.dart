import 'package:freezed_annotation/freezed_annotation.dart';

part 'regular_due_create_request.freezed.dart';
part 'regular_due_create_request.g.dart';

@freezed
abstract class RegularDueCreateRequest with _$RegularDueCreateRequest {
  const factory RegularDueCreateRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    required String title,
    required int amount,
    required String cycleType,
    required String cycleDay,
    required String sendTime,
    required int dueDays,
    required String bankName,
    required String accountNumber,
    required String accountHolder,
    required bool postNotice,
  }) = _RegularDueCreateRequest;
  factory RegularDueCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$RegularDueCreateRequestFromJson(json);
}
