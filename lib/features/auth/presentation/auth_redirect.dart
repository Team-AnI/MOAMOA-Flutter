import 'package:moamoa/core/network/auth_session.dart';

/// 로그인 상태에 따라 보낼 화면 (앱 라우터의 redirect)
extension AuthRedirectX on AuthSessionStatus {
  /// 로그인하지 않아도 볼 수 있는 화면
  ///
  /// 비밀번호 재설정은 메일 링크로 웹에서 열리므로 로그인 여부와 관계없이 엽니다.
  /// 탈퇴 완료는 탈퇴해 로그인하지 않은 상태가 된 뒤에 보여줍니다.
  static const publicPaths = {
    '/login',
    '/signup',
    '/forgot-password',
    '/reset-password',
    '/withdrawn',
  };

  /// 재발급까지 실패해 다시 로그인해야 하는지
  bool get needsReLogin => this == AuthSessionStatus.expired;

  /// [path] 를 열려고 할 때 대신 보낼 경로. 그대로 열면 null 입니다.
  ///
  /// - 로그인하지 않았거나 다시 로그인해야 하면 로그인 화면으로 보냅니다.
  /// - 로그인한 상태에서 로그인 화면을 열면 첫 화면으로 보냅니다.
  String? redirectFrom(String path) {
    if (this == AuthSessionStatus.authenticated) {
      return path == '/login' ? '/' : null;
    }
    return publicPaths.contains(path) ? null : '/login';
  }
}
