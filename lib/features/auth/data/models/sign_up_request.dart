import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_request.freezed.dart';
part 'sign_up_request.g.dart';

/// 회원가입(7-1). [toJson] 은 요청 본문(name, email, password, phone, agreedToTerms)이 됩니다.
///
/// 휴대폰 번호는 선택이라 없으면 본문에서 뺍니다.
@freezed
abstract class SignUpRequest with _$SignUpRequest {
  const factory SignUpRequest({
    required String name,
    required String email,
    required String password,
    @JsonKey(includeIfNull: false) String? phone,
    required bool agreedToTerms,
  }) = _SignUpRequest;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);
}
