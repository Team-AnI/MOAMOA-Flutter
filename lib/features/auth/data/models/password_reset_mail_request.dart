import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_reset_mail_request.freezed.dart';
part 'password_reset_mail_request.g.dart';

/// 비밀번호 재설정 메일 요청(7-5). [toJson] 은 요청 본문(email)이 됩니다.
@freezed
abstract class PasswordResetMailRequest with _$PasswordResetMailRequest {
  const factory PasswordResetMailRequest({required String email}) =
      _PasswordResetMailRequest;

  factory PasswordResetMailRequest.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetMailRequestFromJson(json);
}
