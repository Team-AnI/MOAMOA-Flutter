import 'package:go_router/go_router.dart';

import '../domain/entities/my_account.dart';
import 'pages/forgot_password_page.dart';
import 'pages/login_page.dart';
import 'pages/my_account_page.dart';
import 'pages/profile_edit_page.dart';
import 'pages/profile_setup_page.dart';
import 'pages/reset_password_page.dart';
import 'pages/sign_up_page.dart';

/// 회원·인증 route 목록. `app/router/app_router.dart` 의 `_featureRoutes` 에 추가합니다.
///
/// - /login                       로그인
/// - /signup                      회원가입
/// - /profile-setup               가입 직후 프로필 설정 (로그인한 상태에서만, 이름은 extra 로 받음)
///   회원가입 화면이 아래에 쌓이지 않도록 /signup 의 하위 경로로 두지 않습니다.
/// - /me                          내 계정
/// - /me/edit                     프로필 편집 (내 계정에서 내 정보를 extra 로 받아 엽니다. 없으면 /me 로 보냅니다)
/// - /forgot-password             비밀번호 찾기 (재설정 메일 요청)
/// - /reset-password?token=…       비밀번호 재설정 (메일 링크로 웹에서 열림)
final List<RouteBase> authRoutes = [
  GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
  GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
  GoRoute(
    path: '/profile-setup',
    builder: (context, state) =>
        ProfileSetupPage(userName: state.extra as String?),
  ),
  GoRoute(
    path: '/me',
    builder: (context, state) => const MyAccountPage(),
    routes: [
      GoRoute(
        path: 'edit',
        redirect: (context, state) => state.extra is MyAccount ? null : '/me',
        builder: (context, state) =>
            ProfileEditPage(account: state.extra! as MyAccount),
      ),
    ],
  ),
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
