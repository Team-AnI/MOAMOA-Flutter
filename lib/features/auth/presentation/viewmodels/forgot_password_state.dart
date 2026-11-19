import 'package:freezed_annotation/freezed_annotation.dart';

import 'forgot_password_status.dart';

part 'forgot_password_state.freezed.dart';

/// 비밀번호 재설정 메일 요청 상태. 현재 단계와 실패 원인을 담습니다.
@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    @Default(ForgotPasswordStatus.initial) ForgotPasswordStatus status,

    /// [status] 가 failure 일 때만 값이 있습니다.
    Object? error,
  }) = _ForgotPasswordState;
}

extension ForgotPasswordStateX on ForgotPasswordState {
  bool get isSending => status == ForgotPasswordStatus.sending;
}
