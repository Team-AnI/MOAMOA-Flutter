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
  /// 비밀번호 규칙은 화면에서 먼저 검사하므로, 서버의 validation 오류는 링크 문제입니다.
  bool get isLinkExpired => switch (error) {
    ApiException(code: ApiErrorCode.validation) => true,
    _ => false,
  };
}
