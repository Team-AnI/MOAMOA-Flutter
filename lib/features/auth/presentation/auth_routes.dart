import 'package:go_router/go_router.dart';

import 'pages/forgot_password_page.dart';
import 'pages/reset_password_page.dart';

/// 회원·인증 route 목록. `app/router/app_router.dart` 의 `_featureRoutes` 에 추가합니다.
///
/// - /forgot-password             비밀번호 찾기 (재설정 메일 요청)
/// - /reset-password?token=…       비밀번호 재설정 (메일 링크로 웹에서 열림)
final List<RouteBase> authRoutes = [
  GoRoute(
    path: '/forgot-password',
    builder: (context, state) => const ForgotPasswordPage(),
  ),
  GoRoute(
    path: '/reset-password',
    builder: (context, state) =>
        ResetPasswordPage(token: state.uri.queryParameters['token'] ?? ''),
  ),
];
