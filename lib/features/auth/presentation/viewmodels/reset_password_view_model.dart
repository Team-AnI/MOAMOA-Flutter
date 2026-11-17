import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/network/auth_session.dart';

import '../../domain/usecases/reset_password.dart';
import '../providers/auth_providers.dart';
import 'reset_password_state.dart';
import 'reset_password_status.dart';

/// 비밀번호 재설정 ViewModel (메일 링크로 여는 화면)
///
/// 요청 결과는 반환하지 않고 [ResetPasswordState] 의 단계로 알립니다.
/// 성공하면 로그인해 있던 기기도 로그아웃 상태로 바꿔, 새 비밀번호로 다시 로그인하게 합니다.
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
    // 앱 전체 상태라 이 화면이 닫혀도 바꿀 수 있도록 미리 꺼내 둡니다.
    final session = ref.read(authSessionProvider.notifier);
    try {
      await ref.read(resetPasswordProvider)(
        ResetPasswordParams(token: token, newPassword: newPassword),
      );
      session.signOut();
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
