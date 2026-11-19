import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/network/auth_session.dart';

import '../../domain/usecases/withdraw.dart';
import '../providers/auth_providers.dart';
import 'withdrawal_state.dart';
import 'withdrawal_status.dart';

/// 회원 탈퇴 ViewModel
///
/// 탈퇴하면 화면이 먼저 완료 화면(로그인 없이 볼 수 있는 화면)으로 이동하도록 성공 단계로 바꾼 뒤,
/// 앱 전체 로그인 상태를 로그인하지 않은 상태로 바꿉니다. 순서가 반대면 앱 라우터가
/// 지금 화면을 로그인 화면으로 먼저 보냅니다.
class WithdrawalViewModel extends Notifier<WithdrawalState> {
  @override
  WithdrawalState build() => const WithdrawalState();

  /// [password] 로 본인 확인을 하고 탈퇴합니다.
  Future<void> withdraw({required String password}) async {
    if (state.isSubmitting) return; // 중복 요청 방지
    state = const WithdrawalState(status: WithdrawalStatus.submitting);
    // 탈퇴하면 이 화면이 닫히므로 앱 전체 상태를 미리 꺼내 둡니다.
    final session = ref.read(authSessionProvider.notifier);
    try {
      await ref.read(withdrawProvider)(WithdrawParams(password: password));
    } on Exception catch (error) {
      if (!ref.mounted) return;
      state = WithdrawalState(status: WithdrawalStatus.failure, error: error);
      return;
    }
    if (ref.mounted) {
      state = const WithdrawalState(status: WithdrawalStatus.success);
    }
    session.signOut();
  }
}
