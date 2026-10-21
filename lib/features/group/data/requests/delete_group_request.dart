import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_group_request.freezed.dart';
part 'delete_group_request.g.dart';

@freezed
abstract class DeleteGroupRequest with _$DeleteGroupRequest {
  const factory DeleteGroupRequest({
    @JsonKey(includeToJson: false) required int meetingId,
  }) = _DeleteGroupRequest;

  factory DeleteGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteGroupRequestFromJson(json);
}
