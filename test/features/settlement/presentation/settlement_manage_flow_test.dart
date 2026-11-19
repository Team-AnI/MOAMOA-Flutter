import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/group/presentation/providers/group_members_providers.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';
import 'package:moamoa/features/settlement/presentation/providers/settlement_providers.dart';
import 'package:moamoa/features/settlement/presentation/settlement_routes.dart';
import 'package:moamoa/features/settlement/domain/usecases/cancel_settlement.dart';
import 'package:moamoa/features/settlement/domain/usecases/update_settlement.dart';
import 'package:moamoa/core/errors/api_exception.dart';

import 'settlement_review_test_support.dart' as support;

import 'package:moamoa/features/settlement/presentation/pages/settlement_edit_page.dart';

class _Repository extends support.TestSettlementRepository {
  final response = Completer<void>();
  int listReads = 0, detailReads = 0, cancels = 0, refunds = 0, updates = 0;
  bool done = false;
  SettlementDetail value = support.detail;
  int? lastId;
  @override
  Future<List<RegularDue>> listRegularDues(int meetingId) async => [];
  @override
  Future<List<Settlement>> list(int meetingId) async {
    listReads++;
    return [
      Settlement(
        id: 40,
        title: '모임 회비',
        totalAmount: 15000,
        memberCount: 1,
        dueAt: DateTime(2026, 12, 1),
        createdAt: DateTime(2026, 11, 1),
        status: done ? SettlementStatus.canceled : value.status,
      ),
    ];
  }

  @override
  Future<SettlementDetail> detail(int meetingId, int id) async {
    detailReads++;
    lastId = id;
    return value.copyWith(id: id);
  }

  @override
  Future<void> cancelSettlement(int meetingId, int id, {String? reason}) async {
    cancels++;
    await response.future;
    done = true;
  }

  @override
  Future<void> refundPayment(int meetingId, int id, int paymentId) async {
    refunds++;
    await response.future;
    done = true;
  }

  @override
  Future<void> updateSettlement(
    int meetingId,
    int id,
    SettlementEditInput input,
  ) async {
    updates++;
    await response.future;
    done = true;
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
        groupMembersProvider(7).overrideWith(support.TestMembers.new),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  router.push('/meetings/7/settlements/40');
  await tester.pumpAndSettle();
  return router;
}

Future<void> _tap(WidgetTester tester, String text) async {
  final f = find.text(text).first;
  await tester.scrollUntilVisible(
    f,
    160,
    scrollable: find.byType(Scrollable).first,
  );
  await Scrollable.ensureVisible(tester.element(f), alignment: 0.5);
  await tester.pumpAndSettle();
  await tester.tap(f);
  await tester.pumpAndSettle();
}

void main() {
  for (final width in [393.0, 320.0]) {
    testWidgets('정산 수정 입력 ${width.toInt()}px에서 대상 구성원과 필드를 표시한다', (
      tester,
    ) async {
      await support.pumpReviewPage(
        tester,
        const SettlementEditPage(meetingId: 7, settlementId: 40),
      );
      tester.view.physicalSize = Size(width, 852);
      await tester.pumpAndSettle();
      expect(find.widgetWithText(CheckboxListTile, '김모아'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  for (final action in ['취소', '환불']) {
    testWidgets('$action 요청 중 화면을 닫아도 성공 후 목록을 갱신한다', (tester) async {
      final repo = _Repository();
      if (action == '환불') {
        repo.value = support.detail.copyWith(
          status: SettlementStatus.canceled,
          payments: [
            support.detail.payments.single.copyWith(status: PaymentStatus.paid),
          ],
        );
      }
      final router = await _open(tester, repo);
      final label = action == '취소' ? '정산 취소' : '환불 완료 기록';
      await _tap(tester, label);
      expect(find.byType(AlertDialog), findsOneWidget);
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text(label),
        ),
      );
      await tester.pumpAndSettle();
      expect(action == '취소' ? repo.cancels : repo.refunds, 1);
      router.pop();
      await tester.pumpAndSettle();
      repo.response.complete();
      await tester.pumpAndSettle();
      expect(repo.listReads, 2);
      expect(tester.takeException(), isNull);
    });
  }
  testWidgets('정산 수정 요청 중 뒤로 가도 열린 상세와 목록을 갱신한다', (tester) async {
    final repo = _Repository();
    final router = await _open(tester, repo);
    router.push('/meetings/7/settlements/40/edit');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, '변경한 정산');
    await tester.tap(find.text('저장하기'));
    await tester.pumpAndSettle();
    expect(repo.updates, 1);
    router.pop();
    await tester.pumpAndSettle();
    repo.response.complete();
    await tester.pumpAndSettle();
    expect(repo.detailReads, 2);
    router.pop();
    await tester.pumpAndSettle();
    expect(repo.listReads, 2);
    expect(tester.takeException(), isNull);
  });
  testWidgets('완료된 정산은 취소할 수 있고 환불이 앱 밖 송금임을 안내한다', (tester) async {
    final repo = _Repository()
      ..value = support.detail.copyWith(
        status: SettlementStatus.completed,
        payments: [
          support.detail.payments.single.copyWith(status: PaymentStatus.paid),
        ],
      );
    await _open(tester, repo);
    await _tap(tester, '정산 취소');
    expect(find.textContaining('앱 밖에서'), findsOneWidget);
    expect(find.text('정산을 취소할까요?'), findsOneWidget);
  });
  testWidgets('취소 사유 창은 320x568 키보드에서 스크롤하며 넘치지 않는다', (tester) async {
    await _open(tester, _Repository());
    tester.view.physicalSize = const Size(320, 568);
    await tester.pumpAndSettle();
    await _tap(tester, '정산 취소');
    expect(find.byType(AlertDialog), findsOneWidget);
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
  testWidgets('대체된 정산은 중복 생성 진입 대신 새 정산 링크를 표시한다', (tester) async {
    final repo = _Repository()
      ..value = support.detail.copyWith(
        status: SettlementStatus.canceled,
        cancelReason: '금액 정정',
        replacedBySettlementId: 99,
      );
    await _open(tester, repo);
    expect(find.text('취소된 정산'), findsOneWidget);
    expect(find.text('금액 정정'), findsOneWidget);
    expect(find.text('새 정산으로 대체'), findsNothing);
    await _tap(tester, '새 정산으로 대체됨 · 새 정산 보기');
    expect(repo.lastId, 99);
    expect(tester.takeException(), isNull);
  });
  testWidgets('새 정산에는 원 정산으로 돌아가는 링크가 있다', (tester) async {
    final repo = _Repository()
      ..value = support.detail.copyWith(replacesSettlementId: 20);
    await _open(tester, repo);
    await _tap(tester, '원 정산 보기');
    expect(repo.lastId, 20);
  });
  testWidgets('환불 완료된 항목에는 다시 환불을 기록할 수 없다', (tester) async {
    final repo = _Repository()
      ..value = support.detail.copyWith(
        status: SettlementStatus.canceled,
        payments: [
          support.detail.payments.single.copyWith(
            status: PaymentStatus.refunded,
          ),
        ],
      );
    await _open(tester, repo);
    expect(find.text('환불 완료 기록'), findsNothing);
  });
  test('취소 사유와 수정 입력의 서버 경계값을 UseCase가 검사한다', () async {
    final repo = _Repository();
    final cancel = CancelSettlementImpl(settlementRepository: repo);
    await expectLater(
      cancel(
        CancelSettlementParams(
          meetingId: 7,
          settlementId: 40,
          reason: '가' * 256,
        ),
      ),
      throwsA(isA<ApiException>()),
    );
    expect(repo.cancels, 0);
    final update = UpdateSettlementImpl(settlementRepository: repo);
    await expectLater(
      update(
        const UpdateSettlementParams(
          meetingId: 7,
          settlementId: 40,
          memberCount: 3,
          changes: SettlementEditInput(totalAmount: 2),
        ),
      ),
      throwsA(isA<ApiException>()),
    );
    expect(repo.updates, 0);
  });
}
