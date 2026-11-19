import 'package:freezed_annotation/freezed_annotation.dart';

import 'login_status.dart';

part 'login_state.freezed.dart';

/// 로그인 상태. 현재 단계와 실패 원인을 담습니다.
@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.initial) LoginStatus status,

    /// [status] 가 failure 일 때만 값이 있습니다.
    Object? error,
  }) = _LoginState;
}

extension LoginStateX on LoginState {
  bool get isSubmitting => status == LoginStatus.submitting;
}
