import 'package:go_router/go_router.dart';

import 'pages/vote_create_page.dart';
import 'pages/vote_page.dart';

int _id(GoRouterState state, String name) =>
    int.parse(state.pathParameters[name]!);

/// 투표 만들기 화면 경로입니다. 다른 기능(일정 목록)에서 이동할 때 씁니다.
/// 만들면 만든 일정 id(int)를 돌려주며 닫힙니다.
String voteCreatePath(int meetingId) =>
    '/meetings/$meetingId/schedule-votes/new';

/// 투표 화면 경로입니다. 다른 기능(일정 목록)에서 이동할 때 씁니다.
/// 일정을 확정하면 true 를 돌려주며 닫힙니다.
String votePath(int meetingId, int scheduleId) =>
    '/meetings/$meetingId/schedule-votes/$scheduleId';

/// 투표 feature 의 route. app_router.dart 에서 모아 사용합니다.
/// `new` 가 `:scheduleId` 로 잡히지 않도록 만들기 route 를 먼저 둡니다.
final List<RouteBase> voteRoutes = [
  GoRoute(
    path: '/meetings/:meetingId/schedule-votes/new',
    builder: (_, state) => VoteCreatePage(meetingId: _id(state, 'meetingId')),
  ),
  GoRoute(
    path: '/meetings/:meetingId/schedule-votes/:scheduleId',
    builder: (_, state) => VotePage(
      meetingId: _id(state, 'meetingId'),
      scheduleId: _id(state, 'scheduleId'),
    ),
  ),
];
