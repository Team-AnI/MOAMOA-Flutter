import 'package:go_router/go_router.dart';

import 'pages/schedule_create_page.dart';
import 'pages/schedule_detail_page.dart';
import 'pages/schedule_list_page.dart';

int _id(GoRouterState state, String name) =>
    int.parse(state.pathParameters[name]!);

/// 일정 feature 의 route. app_router.dart 에서 모아 사용합니다.
final List<RouteBase> scheduleRoutes = [
  GoRoute(
    path: '/meetings/:meetingId/schedules',
    builder: (_, state) => ScheduleListPage(meetingId: _id(state, 'meetingId')),
    routes: [
      GoRoute(
        path: 'new',
        builder: (_, state) =>
            ScheduleCreatePage(meetingId: _id(state, 'meetingId')),
      ),
      GoRoute(
        path: ':scheduleId',
        builder: (_, state) => ScheduleDetailPage(
          meetingId: _id(state, 'meetingId'),
          scheduleId: _id(state, 'scheduleId'),
        ),
      ),
    ],
  ),
];
