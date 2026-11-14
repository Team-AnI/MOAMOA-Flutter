import 'package:go_router/go_router.dart';

import 'pages/settlement_create_page.dart';
import 'pages/settlement_detail_page.dart';
import 'pages/settlement_list_page.dart';

final List<RouteBase> settlementRoutes = [
  GoRoute(
    path: '/meetings/:meetingId/settlements',
    redirect: (_, state) =>
        _validId(state.pathParameters['meetingId']) ? null : '/groups',
    builder: (_, state) => SettlementListPage(
      meetingId: int.parse(state.pathParameters['meetingId']!),
    ),
  ),
  GoRoute(
    path: '/meetings/:meetingId/settlements/new',
    redirect: (_, state) =>
        _validId(state.pathParameters['meetingId']) ? null : '/groups',
    builder: (_, state) => SettlementCreatePage(
      meetingId: int.parse(state.pathParameters['meetingId']!),
    ),
  ),
  GoRoute(
    path: '/meetings/:meetingId/settlements/:settlementId',
    redirect: (_, state) =>
        _validId(state.pathParameters['meetingId']) &&
            _validId(state.pathParameters['settlementId'])
        ? null
        : '/groups',
    builder: (_, state) => SettlementDetailPage(
      meetingId: int.parse(state.pathParameters['meetingId']!),
      settlementId: int.parse(state.pathParameters['settlementId']!),
    ),
  ),
];

bool _validId(String? value) => (int.tryParse(value ?? '') ?? 0) > 0;
