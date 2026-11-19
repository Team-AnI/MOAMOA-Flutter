import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_my_profile_request.freezed.dart';
part 'update_my_profile_request.g.dart';

/// 프로필 편집(7-8). [toJson] 은 요청 본문(name, phone, profileColor)이 됩니다.
///
/// 편집 화면은 세 항목을 모두 보냅니다. 휴대폰을 비우면 null 로 보내 지웁니다. (명세 PATCH 규칙)
/// 가입 직후 프로필 색만 바꿀 때는 휴대폰을 지우지 않도록 `UpdateMeRequest` 를 씁니다.
@freezed
abstract class UpdateMyProfileRequest with _$UpdateMyProfileRequest {
  const factory UpdateMyProfileRequest({
    required String name,
    required String? phone,

    /// LIGHT_BLUE·GRAY·BLUE·DARK
    required String profileColor,
  }) = _UpdateMyProfileRequest;

  factory UpdateMyProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateMyProfileRequestFromJson(json);
}
