import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 로그인 상태
enum AuthSessionStatus {
  /// 로그인돼 있거나 아직 확인 전입니다.
  active,

  /// 토큰 재발급까지 실패해 다시 로그인해야 합니다.
  expired,
}

/// 토큰 재발급이 실패하면 [AuthSessionStatus.expired] 로 바뀝니다.
///
/// 로그인 화면으로 보내는 처리는 로그인 기능에서 이 상태를 보고 합니다.
class AuthSession extends Notifier<AuthSessionStatus> {
  @override
  AuthSessionStatus build() => AuthSessionStatus.active;

  void expire() => state = AuthSessionStatus.expired;

  /// 다시 로그인하면 호출합니다.
  void restore() => state = AuthSessionStatus.active;
}

final authSessionProvider = NotifierProvider<AuthSession, AuthSessionStatus>(
  AuthSession.new,
);
