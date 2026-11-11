import 'package:go_router/go_router.dart';

import 'pages/forgot_password_page.dart';

/// 회원·인증 route 목록. `app/router/app_router.dart` 의 `_featureRoutes` 에 추가합니다.
///
/// - /forgot-password    비밀번호 찾기 (재설정 메일 요청)
final List<RouteBase> authRoutes = [
  GoRoute(
    path: '/forgot-password',
    builder: (context, state) => const ForgotPasswordPage(),
  ),
];
