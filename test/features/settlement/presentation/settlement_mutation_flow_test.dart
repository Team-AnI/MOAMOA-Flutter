import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';
import 'package:moamoa/features/settlement/presentation/providers/settlement_providers.dart';
import 'package:moamoa/features/settlement/presentation/settlement_routes.dart';

import 'settlement_review_test_support.dart' as support;

class _Repository extends support.TestSettlementRepository {
  var response = Completer<PaymentAction>();
  int listReads = 0, submissions = 0;
  bool paidSubmitted = false;
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
        status: SettlementStatus.inProgress,
        myAmount: 15000,
        myPaymentStatus: paidSubmitted
            ? PaymentStatus.pending
            : PaymentStatus.unpaid,
      ),
    ];
  }

  @override
  Future<SettlementDetail> detail(int meetingId, int settlementId) async =>
      support.detail.copyWith(
        myPayment: support.detail.myPayment!.copyWith(
          status: paidSubmitted ? PaymentStatus.pending : PaymentStatus.unpaid,
        ),
      );
  @override
  Future<PaymentAction> submitPayment(int meetingId, int settlementId) {
    submissions++;
    return response.future;
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
  return router;
}

Future<void> submit(WidgetTester tester) async {
  // 오류 안내가 사라진 뒤 같은 버튼으로 재시도합니다.
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
  await tester.scrollUntilVisible(
    find.text('납부했어요'),
    200,
    scrollable: find.byType(Scrollable).last,
  );
  await Scrollable.ensureVisible(
    tester.element(find.text('납부했어요')),
    alignment: 0.5,
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('납부했어요'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('제출'));
  await tester.pumpAndSettle();
}

void main() {
  group('settlementActionsProvider', () {
    for (final leave in [false, true]) {
      testWidgets(
        '실제 라우터: 납부 요청 ${leave ? "중 뒤로 이동해도" : "완료 후 복귀하면"} 목록을 갱신한다',
        (tester) async {
          final repo = _Repository();
          final router = await _open(tester, repo);
          await submit(tester);
          expect(repo.submissions, 1);
          if (leave) {
            router.pop();
            await tester.pumpAndSettle();
          }
          repo.paidSubmitted = true;
          repo.response.complete(
            const PaymentAction(paymentId: 81, status: PaymentStatus.pending),
          );
          await tester.pumpAndSettle();
          if (!leave) {
            router.pop();
            await tester.pumpAndSettle();
          }
          expect(repo.listReads, 2);
          expect(tester.takeException(), isNull);
          router.push('/meetings/7/settlements/40');
          await tester.pumpAndSettle();
          expect(find.text('납부했어요'), findsNothing);
        },
      );
    }
    test('작업 상태는 같은 모임의 중복 요청을 막고 다른 모임과 분리된다', () async {
      final repo = _Repository();
      final container = ProviderContainer(
        overrides: [settlementRepositoryProvider.overrideWithValue(repo)],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        settlementActionsProvider(7),
        (_, _) {},
      );
      addTearDown(subscription.close);
      final notifier = container.read(settlementActionsProvider(7).notifier);
      final pending = notifier.submit(40);
      expect(container.read(settlementActionsProvider(7)).isSubmitting, isTrue);
      expect(
        container.read(settlementActionsProvider(8)).isSubmitting,
        isFalse,
      );
      await notifier.submit(40);
      expect(repo.submissions, 1);
      repo.response.complete(
        const PaymentAction(paymentId: 81, status: PaymentStatus.pending),
      );
      await pending;
      expect(
        container.read(settlementActionsProvider(7)).isSubmitting,
        isFalse,
      );
    });
    testWidgets('화면 이탈 후 실패 응답도 닫힌 화면을 사용하지 않는다', (tester) async {
      final repo = _Repository();
      final router = await _open(tester, repo);
      await submit(tester);
      router.pop();
      await tester.pumpAndSettle();
      repo.response.completeError(
        const ApiException(code: ApiErrorCode.network),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
    test('ProviderScope 종료 후 늦은 응답은 폐기된 상태에 접근하지 않는다', () async {
      final repo = _Repository();
      final container = ProviderContainer(
        overrides: [settlementRepositoryProvider.overrideWithValue(repo)],
      );
      container.listen(settlementActionsProvider(7), (_, _) {});
      final pending = container
          .read(settlementActionsProvider(7).notifier)
          .submit(40);
      container.dispose();
      repo.response.complete(
        const PaymentAction(paymentId: 81, status: PaymentStatus.pending),
      );
      await expectLater(pending, completes);
    });
    test('서버가 이미 처리됨을 알리면 캐시를 재조회하고 재시도를 허용한다', () async {
      final repo = _Repository();
      var listReads = 0;
      final container = ProviderContainer(
        overrides: [
          settlementRepositoryProvider.overrideWithValue(repo),
          settlementListProvider.overrideWith((ref, id) async {
            listReads++;
            return [];
          }),
        ],
      );
      addTearDown(container.dispose);
      container.listen(settlementListProvider(7), (_, _) {});
      container.listen(settlementActionsProvider(7), (_, _) {});
      await container.read(settlementListProvider(7).future);
      final notifier = container.read(settlementActionsProvider(7).notifier);
      final pending = notifier.submit(40);
      repo.response.completeError(
        const ApiException(code: ApiErrorCode.conflict),
      );
      await pending;
      expect(
        container.read(settlementActionsProvider(7)).failure?.code,
        ApiErrorCode.conflict,
      );
      await container.read(settlementListProvider(7).future);
      expect(listReads, 2);
      expect(
        container.read(settlementActionsProvider(7)).isSubmitting,
        isFalse,
      );
      repo.response = Completer<PaymentAction>();
      final retry = notifier.submit(40);
      repo.response.complete(
        const PaymentAction(paymentId: 81, status: PaymentStatus.pending),
      );
      await retry;
      expect(repo.submissions, 2);
    });

    testWidgets('납부 실패를 안내한 뒤 재시도하면 목록을 갱신한다', (tester) async {
      final repo = _Repository();
      await _open(tester, repo);
      await submit(tester);
      repo.response.completeError(
        const ApiException(code: ApiErrorCode.network),
      );
      await tester.pumpAndSettle();
      expect(find.text('네트워크 연결을 확인해주세요.'), findsOneWidget);
      repo.response = Completer<PaymentAction>();
      await submit(tester);
      expect(repo.submissions, 2);
      repo.paidSubmitted = true;
      repo.response.complete(
        const PaymentAction(paymentId: 81, status: PaymentStatus.pending),
      );
      await tester.pumpAndSettle();
      expect(find.text('납부했어요'), findsNothing);
      expect(tester.takeException(), isNull);
    });
    test('상세 키는 이름 있는 모임·정산 ID로 같은 값과 다른 모임을 구분한다', () {
      expect(
        const SettlementDetailRequest(meetingId: 7, settlementId: 40),
        const SettlementDetailRequest(meetingId: 7, settlementId: 40),
      );
      expect(
        const SettlementDetailRequest(meetingId: 7, settlementId: 40),
        isNot(const SettlementDetailRequest(meetingId: 8, settlementId: 40)),
      );
    });
  });
}
