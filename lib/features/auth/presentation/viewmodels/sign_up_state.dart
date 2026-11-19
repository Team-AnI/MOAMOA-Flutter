import 'package:freezed_annotation/freezed_annotation.dart';

import 'sign_up_status.dart';

part 'sign_up_state.freezed.dart';

/// 회원가입 상태. 현재 단계와 실패 원인을 담습니다.
@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(SignUpStatus.initial) SignUpStatus status,

    /// [status] 가 failure 일 때만 값이 있습니다.
    Object? error,
  }) = _SignUpState;
}

extension SignUpStateX on SignUpState {
  bool get isSubmitting => status == SignUpStatus.submitting;
}
