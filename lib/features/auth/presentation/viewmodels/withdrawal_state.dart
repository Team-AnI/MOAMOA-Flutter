import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';

import 'withdrawal_status.dart';

part 'withdrawal_state.freezed.dart';

/// 회원 탈퇴 상태. 현재 단계와 실패 원인을 담습니다.
@freezed
abstract class WithdrawalState with _$WithdrawalState {
  const factory WithdrawalState({
    @Default(WithdrawalStatus.initial) WithdrawalStatus status,

    /// [status] 가 failure 일 때만 값이 있습니다.
    Object? error,
  }) = _WithdrawalState;
}

extension WithdrawalStateX on WithdrawalState {
  bool get isSubmitting => status == WithdrawalStatus.submitting;

  /// 비밀번호가 틀렸는지 (7-9 의 400 VALIDATION_ERROR)
  ///
  /// 7-9 는 비밀번호가 틀려도 401 이 아니라 400 을 보냅니다. 401 은 토큰 재발급 신호라서입니다.
  /// 비밀번호를 비운 요청은 화면에서 막으므로, 여기서는 validation 오류를 비밀번호 오류로 봅니다.
  bool get isWrongPassword => switch (error) {
    ApiException(code: ApiErrorCode.validation) => true,
    _ => false,
  };
}
