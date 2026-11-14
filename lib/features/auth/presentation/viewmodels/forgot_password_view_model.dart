import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/request_password_reset.dart';
import '../providers/auth_providers.dart';
import 'forgot_password_state.dart';
import 'forgot_password_status.dart';

/// 비밀번호 찾기 ViewModel
///
/// 요청 결과는 반환하지 않고 [ForgotPasswordState] 의 단계로 알립니다.
class ForgotPasswordViewModel extends Notifier<ForgotPasswordState> {
  @override
  ForgotPasswordState build() => const ForgotPasswordState();

  /// [email] 로 재설정 메일을 요청합니다.
  Future<void> request(String email) async {
    if (state.isSending) return; // 중복 요청 방지
    state = const ForgotPasswordState(status: ForgotPasswordStatus.sending);
    try {
      await ref.read(requestPasswordResetProvider)(
        RequestPasswordResetParams(email: email),
      );
      if (!ref.mounted) return;
      state = const ForgotPasswordState(status: ForgotPasswordStatus.sent);
    } on Exception catch (error) {
      if (!ref.mounted) return;
      state = ForgotPasswordState(
        status: ForgotPasswordStatus.failure,
        error: error,
      );
    }
  }
}
