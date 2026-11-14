import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 로그인 상태
enum AuthSessionStatus {
  /// 로그인하지 않았습니다. 저장된 토큰이 없습니다. (처음 상태, 로그아웃·탈퇴 뒤)
  unauthorized,

  /// 로그인했고 토큰이 유효합니다.
  authenticated,

  /// 로그인했지만 토큰이 유효하지 않고, 리프레시 토큰까지 만료돼(재발급 401) 다시 로그인해야 합니다.
  ///
  /// 액세스 토큰이 유효하지 않은 것은 처음에는 알 수 없고, API 요청이 403(또는 401)으로 실패할 때 알게 됩니다.
  /// 이때 인터셉터가 재발급을 시도하고, 재발급까지 401 이면 이 상태가 됩니다.
  expired,
}

/// 로그인 상태를 담습니다. 처음에는 [AuthSessionStatus.unauthorized] 입니다.
///
/// 로그인 화면으로 보내는 처리는 로그인 기능에서 이 상태를 보고 합니다.
class AuthSession extends Notifier<AuthSessionStatus> {
  @override
  AuthSessionStatus build() => AuthSessionStatus.unauthorized;

  /// 로그인·회원가입으로 토큰을 받으면 호출합니다.
  void authenticate() => state = AuthSessionStatus.authenticated;

  /// 토큰 재발급까지 실패하면 인터셉터가 호출합니다.
  void expire() => state = AuthSessionStatus.expired;

  /// 로그아웃·탈퇴로 토큰을 지우면 호출합니다.
  void signOut() => state = AuthSessionStatus.unauthorized;
}

final authSessionProvider = NotifierProvider<AuthSession, AuthSessionStatus>(
  AuthSession.new,
);
