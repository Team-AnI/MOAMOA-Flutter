import 'package:go_router/go_router.dart';

import 'pages/vote_create_page.dart';

int _id(GoRouterState state, String name) =>
    int.parse(state.pathParameters[name]!);

/// 투표 feature 의 route. app_router.dart 에서 모아 사용합니다.
final List<RouteBase> voteRoutes = [
  GoRoute(
    path: '/meetings/:meetingId/schedule-votes/new',
    builder: (_, state) => VoteCreatePage(meetingId: _id(state, 'meetingId')),
  ),
];
