import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/reset_password.dart';
import '../providers/auth_providers.dart';
import 'reset_password_state.dart';
import 'reset_password_status.dart';

/// 비밀번호 재설정 ViewModel (메일 링크로 여는 화면)
///
/// 요청 결과는 반환하지 않고 [ResetPasswordState] 의 단계로 알립니다.
class ResetPasswordViewModel extends Notifier<ResetPasswordState> {
  @override
  ResetPasswordState build() => const ResetPasswordState();

  /// 링크의 [token] 과 [newPassword] 로 비밀번호를 바꿉니다.
  Future<void> submit({
    required String token,
    required String newPassword,
  }) async {
    if (state.isSubmitting) return; // 중복 요청 방지
    state = const ResetPasswordState(status: ResetPasswordStatus.submitting);
    try {
      await ref.read(resetPasswordProvider)(
        ResetPasswordParams(token: token, newPassword: newPassword),
      );
      if (!ref.mounted) return;
      state = const ResetPasswordState(status: ResetPasswordStatus.success);
    } on Exception catch (error) {
      if (!ref.mounted) return;
      state = ResetPasswordState(
        status: ResetPasswordStatus.failure,
        error: error,
      );
    }
  }
}
