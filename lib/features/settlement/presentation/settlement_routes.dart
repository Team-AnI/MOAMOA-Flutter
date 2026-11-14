import 'package:go_router/go_router.dart';

import 'pages/settlement_create_page.dart';
import 'pages/settlement_detail_page.dart';
import 'pages/settlement_list_page.dart';
import 'pages/settlement_history_page.dart';
import 'pages/regular_dues_form_page.dart';
import 'pages/settlement_edit_page.dart';

final List<RouteBase> settlementRoutes = [
  GoRoute(
    path: '/meetings/:meetingId/settlements/history',
    redirect: (_, state) =>
        _validId(state.pathParameters['meetingId']) ? null : '/groups',
    builder: (_, state) => SettlementHistoryPage(
      meetingId: int.parse(state.pathParameters['meetingId']!),
    ),
  ),
  GoRoute(
    path: '/meetings/:meetingId/regular-dues/new',
    redirect: (_, state) =>
        _validId(state.pathParameters['meetingId']) ? null : '/groups',
    builder: (_, state) => RegularDuesFormPage(
      meetingId: int.parse(state.pathParameters['meetingId']!),
    ),
  ),
  GoRoute(
    path: '/meetings/:meetingId/regular-dues/:regularDuesId/edit',
    redirect: (_, state) =>
        _validId(state.pathParameters['meetingId']) &&
            _validId(state.pathParameters['regularDuesId'])
        ? null
        : '/groups',
    builder: (_, state) => RegularDuesFormPage(
      meetingId: int.parse(state.pathParameters['meetingId']!),
      regularDuesId: int.parse(state.pathParameters['regularDuesId']!),
    ),
  ),
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
      replacesSettlementId: int.tryParse(
        state.uri.queryParameters['replacesSettlementId'] ?? '',
      ),
    ),
  ),
  GoRoute(
    path: '/meetings/:meetingId/settlements/:settlementId/edit',
    redirect: (_, state) =>
        _validId(state.pathParameters['meetingId']) &&
            _validId(state.pathParameters['settlementId'])
        ? null
        : '/groups',
    builder: (_, state) => SettlementEditPage(
      meetingId: int.parse(state.pathParameters['meetingId']!),
      settlementId: int.parse(state.pathParameters['settlementId']!),
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
