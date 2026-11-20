import 'package:freezed_annotation/freezed_annotation.dart';

part 'regular_due_delete_request.freezed.dart';
part 'regular_due_delete_request.g.dart';

@freezed
abstract class RegularDueDeleteRequest with _$RegularDueDeleteRequest {
  const factory RegularDueDeleteRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    @JsonKey(includeToJson: false) required int regularDuesId,
  }) = _RegularDueDeleteRequest;
  factory RegularDueDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$RegularDueDeleteRequestFromJson(json);
}
