import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';
import 'package:moamoa/features/settlement/domain/entities/regular_due_update.dart';
import 'package:moamoa/features/settlement/presentation/providers/settlement_providers.dart';
import 'package:moamoa/features/settlement/presentation/settlement_routes.dart';

import 'settlement_review_test_support.dart' as support;
import 'regular_due_changes_test.dart' as fixture;

class _Repository extends support.TestSettlementRepository {
  final response = Completer<bool?>();
  int updates = 0, regularReads = 0;
  final detailReads = <int, int>{};
  bool updated = false;
  @override
  Future<List<Settlement>> list(int meetingId) async => [
    Settlement(
      id: 40,
      title: '회비',
      totalAmount: 10000,
      memberCount: 1,
      dueAt: DateTime(2026, 12, 1),
      createdAt: DateTime(2026, 11, 1),
      status: SettlementStatus.inProgress,
    ),
  ];
  @override
  Future<SettlementDetail> detail(int meetingId, int id) async {
    detailReads.update(meetingId, (v) => v + 1, ifAbsent: () => 1);
    return support.detail.copyWith(title: updated ? '수정한 회비' : '회비');
  }

  @override
  Future<List<RegularDue>> listRegularDues(int meetingId) async {
    regularReads++;
    return [fixture.previous];
  }

  @override
  Future<bool?> updateRegularDue(
    int meetingId,
    int id,
    RegularDueUpdate changes,
  ) async {
    updates++;
    final result = await response.future;
    updated = true;
    return result;
  }
}

Future<GoRouter> _open(WidgetTester tester, _Repository repo) async {
  tester.view.physicalSize = const Size(393, 852);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final router = GoRouter(
    initialLocation: '/meetings/7/settlements',
    routes: settlementRoutes,
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        groupMyRoleProvider.overrideWith((ref, id) async => MemberRole.admin),
        settlementRepositoryProvider.overrideWithValue(repo),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  router.push('/meetings/7/settlements/40');
  await tester.pumpAndSettle();
  router.push('/meetings/7/regular-dues/7/edit');
  await tester.pumpAndSettle();
  return router;
}

Future<void> _save(WidgetTester tester, {bool apply = true}) async {
  await tester.enterText(find.byType(TextFormField).first, '수정한 회비');
  if (apply) {
    final checkbox = find.widgetWithText(CheckboxListTile, '이번 회차에도 변경 적용');
    await tester.scrollUntilVisible(
      checkbox,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.ensureVisible(checkbox);
    await tester.tap(checkbox);
    await tester.pumpAndSettle();
  }
  await tester.tap(find.text('변경사항 저장'));
  await tester.pumpAndSettle();
}

void main() {
  for (final scenario in [
    (true, '설정과 이번 회차 정산에 적용했어요.'),
    (false, '설정은 저장했지만 이번 회차에는 적용되지 않았어요. 기존 정산을 확인해 주세요.'),
    (null, '설정은 저장했지만 이번 회차 적용 여부를 확인하지 못했어요. 정산을 확인해 주세요.'),
  ]) {
    testWidgets('이번 회차 적용 ${scenario.$1} 결과 안내와 열린 상세 갱신', (tester) async {
      final repo = _Repository();
      await _open(tester, repo);
      await _save(tester);
      repo.response.complete(scenario.$1);
      await tester.pumpAndSettle();
      expect(find.text(scenario.$2), findsOneWidget);
      expect(repo.detailReads[7], 2);
      expect(tester.takeException(), isNull);
    });
  }
  testWidgets('적용 미요청의 null은 정상 저장 안내이고 상세를 재조회하지 않는다', (tester) async {
    final repo = _Repository();
    await _open(tester, repo);
    await _save(tester, apply: false);
    repo.response.complete(null);
    await tester.pumpAndSettle();
    expect(find.text('정기 회비를 저장했어요.'), findsOneWidget);
    expect(repo.detailReads[7], 1);
  });
  testWidgets('수정 요청 중 뒤로 가도 완료 후 목록과 상세를 갱신한다', (tester) async {
    final repo = _Repository();
    final router = await _open(tester, repo);
    await _save(tester);
    router.pop();
    await tester.pumpAndSettle();
    repo.response.complete(true);
    await tester.pumpAndSettle();
    expect(repo.detailReads[7], 2);
    router.pop();
    await tester.pumpAndSettle();
    expect(repo.regularReads, 2);
    expect(tester.takeException(), isNull);
  });
  test('회차 적용은 현재 모임 상세만 갱신하고 다른 모임 캐시는 유지한다', () async {
    final repo = _Repository();
    final container = ProviderContainer(
      overrides: [settlementRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    const key7 = SettlementDetailRequest(meetingId: 7, settlementId: 40),
        key8 = SettlementDetailRequest(meetingId: 8, settlementId: 40);
    container.listen(settlementDetailProvider(key7), (_, _) {});
    container.listen(settlementDetailProvider(key8), (_, _) {});
    await container.read(settlementDetailProvider(key7).future);
    await container.read(settlementDetailProvider(key8).future);
    container.listen(regularDueActionsProvider(7), (_, _) {});
    final actions = container.read(regularDueActionsProvider(7).notifier);
    final first = actions.update(
      7,
      const RegularDueUpdate(title: '수정', applyToCurrentSettlement: true),
    );
    expect(
      await actions.update(7, const RegularDueUpdate(title: '중복')),
      isNull,
    );
    expect(repo.updates, 1);
    repo.response.complete(true);
    await first;
    await container.read(settlementDetailProvider(key7).future);
    expect(repo.detailReads[7], 2);
    expect(repo.detailReads[8], 1);
  });
}
