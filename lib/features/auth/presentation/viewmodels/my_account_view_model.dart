import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/core/usecases/usecase.dart';

import '../providers/auth_providers.dart';
import 'my_account_state.dart';
import 'my_account_status.dart';

/// 내 계정 ViewModel
///
/// 처음에는 불러오는 중 상태를 바로 돌려주고, 화면이 구독한 뒤 내 정보를 불러옵니다.
class MyAccountViewModel extends Notifier<MyAccountState> {
  @override
  MyAccountState build() {
    scheduleMicrotask(() {
      if (ref.mounted) unawaited(load());
    });
    return const MyAccountState();
  }

  /// 내 정보를 불러옵니다. 실패하면 다시 시도할 수 있습니다.
  Future<void> load() async {
    state = const MyAccountState();
    try {
      final account = await ref.read(getMyAccountProvider)(const NoParams());
      if (!ref.mounted) return;
      state = MyAccountState(status: MyAccountStatus.loaded, account: account);
    } on Exception catch (error) {
      if (!ref.mounted) return;
      state = MyAccountState(status: MyAccountStatus.failure, error: error);
    }
  }

  /// 로그아웃합니다. 서버 요청이 실패해도 기기의 토큰은 지워졌으므로 로그아웃한 상태로 바꿉니다.
  Future<void> logout() async {
    if (state.isLoggingOut) return; // 중복 요청 방지
    state = state.copyWith(isLoggingOut: true);
    // 로그아웃하면 이 화면이 닫히므로 앱 전체 상태를 미리 꺼내 둡니다.
    final session = ref.read(authSessionProvider.notifier);
    try {
      await ref.read(logoutProvider)(const NoParams());
    } on Exception {
      // 토큰은 이미 지워졌습니다. 화면은 로그인 화면으로 이동합니다.
    }
    session.signOut();
  }
}
