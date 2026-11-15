import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';

import 'reset_password_status.dart';

part 'reset_password_state.freezed.dart';

/// 새 비밀번호 설정 상태. 현재 단계와 실패 원인을 담습니다.
@freezed
abstract class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState({
    @Default(ResetPasswordStatus.initial) ResetPasswordStatus status,

    /// [status] 가 failure 일 때만 값이 있습니다.
    Object? error,
  }) = _ResetPasswordState;
}

extension ResetPasswordStateX on ResetPasswordState {
  bool get isSubmitting => status == ResetPasswordStatus.submitting;

  /// 링크가 만료되었거나 이미 쓰였는지 (7-6 의 400 VALIDATION_ERROR)
  ///
  /// 7-6 은 비밀번호 규칙 위반에도 같은 400 VALIDATION_ERROR 를 보냅니다. (명세 7-6 Error 표)
  /// 비밀번호 규칙은 화면이 먼저 검사해 규칙에 맞을 때만 요청하므로, 여기서는 validation 오류를
  /// 링크 문제로 봅니다. (명세 7-6 Notes: "400 은 주로 토큰 만료·사용됨")
  /// `ResetPassword` UseCase 의 검사도 화면과 같은 규칙이라, 화면을 거친 요청에서는 나오지 않습니다.
  /// 서버가 두 오류를 구분해 주면(예: details.field) 그 값으로 판단하도록 바꿉니다.
  bool get isLinkExpired => switch (error) {
    ApiException(code: ApiErrorCode.validation) => true,
    _ => false,
  };
}
