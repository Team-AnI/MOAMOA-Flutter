import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_me_request.freezed.dart';
part 'update_me_request.g.dart';

/// 내 정보 수정(7-8). [toJson] 은 요청 본문이 됩니다.
///
/// 부분 수정이라 값이 없는 항목은 본문에서 빼 기존 값을 유지합니다. (명세 PATCH 규칙)
/// 지금은 가입 직후 프로필 색만 보냅니다. 이름·휴대폰은 내 정보 화면에서 더합니다.
@freezed
abstract class UpdateMeRequest with _$UpdateMeRequest {
  const factory UpdateMeRequest({
    /// LIGHT_BLUE·GRAY·BLUE·DARK
    @JsonKey(includeIfNull: false) String? profileColor,
  }) = _UpdateMeRequest;

  factory UpdateMeRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateMeRequestFromJson(json);
}
