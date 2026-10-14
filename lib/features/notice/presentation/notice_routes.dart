import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'pages/notice_detail_page.dart';
import 'pages/notice_list_page.dart';
import 'pages/notice_write_page.dart';
import 'providers/notice_providers.dart';

/// 공지 route 목록. `app/router/app_router.dart` 의 `_featureRoutes` 에 추가합니다.
///
/// - /meetings/:meetingId/notices                    공지 목록
/// - /meetings/:meetingId/notices/new                공지 작성 (관리자만)
/// - /meetings/:meetingId/notices/:noticeId          공지 상세
/// - /meetings/:meetingId/notices/:noticeId/edit     공지 수정 (관리자만)
final List<RouteBase> noticeRoutes = [
  GoRoute(
    path: '/meetings/:meetingId/notices',
    builder: (context, state) => NoticeListPage(meetingId: _meetingId(state)),
    routes: [
      // 'new' 가 ':noticeId' 보다 먼저 와야 합니다.
      GoRoute(
        path: 'new',
        redirect: _adminOnly,
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
            redirect: _adminOnly,
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

/// 관리자만 들어갈 수 있는 화면의 진입 가드
///
/// 관리자가 아니면(또는 관리자인지 확인하지 못하면) 공지 목록으로 보냅니다.
/// 최종 권한 확인은 서버가 하지만, 구성원에게는 폼을 열어 주지 않습니다.
Future<String?> _adminOnly(BuildContext context, GoRouterState state) async {
  final meetingId = _meetingId(state);
  final container = ProviderScope.containerOf(context, listen: false);
  // autoDispose provider 가 응답 도착 전에 정리되지 않도록 구독을 유지합니다.
  final subscription = container.listen(
    noticeMyRoleProvider(meetingId),
    (_, _) {},
  );
  try {
    final role = await container.read(noticeMyRoleProvider(meetingId).future);
    if (role.isAdmin) return null;
  } catch (_) {
    // 역할을 확인하지 못했으면 들여보내지 않습니다.
  } finally {
    subscription.close();
  }
  return '/meetings/$meetingId/notices';
}
