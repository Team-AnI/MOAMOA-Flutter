import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/features/schedule/presentation/schedule_routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// 각 feature 의 route 목록을 모으기만 합니다.
///
/// 새 화면의 route 는 해당 feature 의 `presentation/` 안에 정의하고
/// (예: `features/auth/presentation/auth_routes.dart`),
/// 여기서는 아래 [_featureRoutes] 에 한 줄만 추가합니다.
/// (동시 작업 시 충돌을 줄이기 위함)
final List<RouteBase> _featureRoutes = [
  // ...authRoutes,
  // ...groupRoutes,
  ...scheduleRoutes,
  // ...noticeRoutes,
  // ...settlementRoutes,
];

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const _PlaceholderPage()),
      ..._featureRoutes,
    ],
  );
}

/// 첫 화면이 생기기 전까지 사용하는 임시 화면입니다. (첫 화면 구현 시 제거)
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('MOAMOA')));
  }
}
