import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_group_request.freezed.dart';
part 'update_group_request.g.dart';

@freezed
abstract class UpdateGroupRequest with _$UpdateGroupRequest {
  const factory UpdateGroupRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    @JsonKey(includeIfNull: false) String? name,
    @JsonKey(includeIfNull: false) String? description,
  }) = _UpdateGroupRequest;

  factory UpdateGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateGroupRequestFromJson(json);
}

/// null은 미변경, 빈 문자열은 소개 비우기라는 앱 입력을 PATCH 계약으로 변환합니다.
extension UpdateGroupRequestX on UpdateGroupRequest {
  Map<String, dynamic> toPatchJson() => {
    ...toJson(),
    if (description == '') 'description': null,
  };
}
