import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/network/auth_session.dart';
import 'package:moamoa/features/schedule/presentation/schedule_routes.dart';

import '../../features/auth/presentation/auth_redirect.dart';
import '../../features/auth/presentation/auth_routes.dart';
import '../../features/group/presentation/group_routes.dart';
import '../../features/notice/presentation/notice_routes.dart';

/// 각 feature 의 route 목록을 모으기만 합니다.
///
/// 새 화면의 route 는 해당 feature 의 `presentation/` 안에 정의하고
/// (예: `features/auth/presentation/auth_routes.dart`),
/// 여기서는 아래 [_featureRoutes] 에 한 줄만 추가합니다.
/// (동시 작업 시 충돌을 줄이기 위함)
final List<RouteBase> _featureRoutes = [
  ...authRoutes,
  ...groupRoutes,
  ...scheduleRoutes,
  ...noticeRoutes,
  // ...settlementRoutes,
];

final appRouterProvider = Provider<GoRouter>((ref) {
  // 로그인 상태가 바뀌면(로그인·로그아웃·재발급 실패) 지금 화면을 다시 확인합니다.
  final authStatus = ValueNotifier(ref.read(authSessionProvider));
  ref.listen(authSessionProvider, (_, next) => authStatus.value = next);
  ref.onDispose(authStatus.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: authStatus,
    // 로그인하지 않았으면 로그인 화면으로 보냅니다. 규칙은 auth 기능의 AuthRedirectX 에 있습니다.
    redirect: (context, state) => authStatus.value.redirectFrom(state.uri.path),
    routes: [
      GoRoute(path: '/', builder: (context, state) => const _PlaceholderPage()),
      ..._featureRoutes,
    ],
  );
});

/// 첫 화면이 생기기 전까지 사용하는 임시 화면입니다. (첫 화면 구현 시 제거)
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('MOAMOA'),
            FilledButton(
              onPressed: () => context.go('/groups'),
              child: const Text('내 모임'),
            ),
          ],
        ),
      ),
    );
  }
}
