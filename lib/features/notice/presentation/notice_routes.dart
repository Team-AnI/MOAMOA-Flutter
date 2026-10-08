import 'package:go_router/go_router.dart';

import 'pages/notice_detail_page.dart';
import 'pages/notice_list_page.dart';
import 'pages/notice_write_page.dart';

/// 공지 route 목록. `app/router/app_router.dart` 의 `_featureRoutes` 에 추가합니다.
///
/// - /meetings/:meetingId/notices                    공지 목록
/// - /meetings/:meetingId/notices/new                공지 작성
/// - /meetings/:meetingId/notices/:noticeId          공지 상세
/// - /meetings/:meetingId/notices/:noticeId/edit     공지 수정
final List<RouteBase> noticeRoutes = [
  GoRoute(
    path: '/meetings/:meetingId/notices',
    builder: (context, state) => NoticeListPage(meetingId: _meetingId(state)),
    routes: [
      // 'new' 가 ':noticeId' 보다 먼저 와야 합니다.
      GoRoute(
        path: 'new',
        builder: (context, state) =>
            NoticeWritePage(meetingId: _meetingId(state)),
      ),
      GoRoute(
        path: ':noticeId',
        builder: (context, state) => NoticeDetailPage(
          meetingId: _meetingId(state),
          noticeId: _noticeId(state),
        ),
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) => NoticeWritePage(
              meetingId: _meetingId(state),
              noticeId: _noticeId(state),
            ),
          ),
        ],
      ),
    ],
  ),
];

int _meetingId(GoRouterState state) =>
    int.parse(state.pathParameters['meetingId']!);

int _noticeId(GoRouterState state) =>
    int.parse(state.pathParameters['noticeId']!);
