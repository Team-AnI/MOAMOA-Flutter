import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/network/auth_session.dart';

import '../../domain/usecases/login_with_email.dart';
import '../providers/auth_providers.dart';
import 'login_state.dart';
import 'login_status.dart';

/// 로그인 ViewModel
///
/// 요청 결과는 반환하지 않고 [LoginState] 의 단계로 알립니다.
/// 성공하면 앱 전체 로그인 상태([AuthSession])를 로그인한 상태로 바꿉니다.
class LoginViewModel extends Notifier<LoginState> {
  @override
  LoginState build() => const LoginState();

  /// [email]·[password] 로 로그인합니다.
  Future<void> login({required String email, required String password}) async {
    if (state.isSubmitting) return; // 중복 요청 방지
    state = const LoginState(status: LoginStatus.submitting);
    // 앱 전체 상태라 이 화면이 닫혀도 바꿀 수 있도록 미리 꺼내 둡니다.
    final session = ref.read(authSessionProvider.notifier);
    try {
      await ref.read(loginWithEmailProvider)(
        LoginWithEmailParams(email: email, password: password),
      );
      session.authenticate();
      if (!ref.mounted) return;
      state = const LoginState(status: LoginStatus.success);
    } on Exception catch (error) {
      if (!ref.mounted) return;
      state = LoginState(status: LoginStatus.failure, error: error);
    }
  }
}
