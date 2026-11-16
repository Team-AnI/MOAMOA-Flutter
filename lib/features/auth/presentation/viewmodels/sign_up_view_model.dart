import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/network/auth_session.dart';

import '../../domain/usecases/sign_up_with_email.dart';
import '../providers/auth_providers.dart';
import 'sign_up_state.dart';
import 'sign_up_status.dart';

/// 회원가입 ViewModel
///
/// 요청 결과는 반환하지 않고 [SignUpState] 의 단계로 알립니다.
/// 가입하면 토큰을 함께 받으므로 앱 전체 로그인 상태([AuthSession])를 로그인한 상태로 바꿉니다.
class SignUpViewModel extends Notifier<SignUpState> {
  @override
  SignUpState build() => const SignUpState();

  /// 입력한 값으로 가입합니다. [phone] 은 비어 있으면 보내지 않습니다.
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    required bool agreedToTerms,
  }) async {
    if (state.isSubmitting) return; // 중복 요청 방지
    state = const SignUpState(status: SignUpStatus.submitting);
    // 앱 전체 상태라 이 화면이 닫혀도 바꿀 수 있도록 미리 꺼내 둡니다.
    final session = ref.read(authSessionProvider.notifier);
    try {
      await ref.read(signUpWithEmailProvider)(
        SignUpWithEmailParams(
          name: name,
          email: email,
          password: password,
          phone: phone,
          agreedToTerms: agreedToTerms,
        ),
      );
      session.authenticate();
      if (!ref.mounted) return;
      state = const SignUpState(status: SignUpStatus.success);
    } on Exception catch (error) {
      if (!ref.mounted) return;
      state = SignUpState(status: SignUpStatus.failure, error: error);
    }
  }
}
