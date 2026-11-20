import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';
import 'package:moamoa/features/settlement/presentation/pages/settlement_detail_page.dart';
import 'package:moamoa/features/settlement/presentation/providers/settlement_providers.dart';

void main() {
  group(SettlementDetailPage, () {
    final detail = SettlementDetail(
      id: 40,
      title: '모임 회비',
      totalAmount: 15000,
      bankName: '국민은행',
      accountNumber: '1234',
      accountHolder: '김모아',
      dueAt: DateTime(2026, 11, 17),
      status: SettlementStatus.inProgress,
      myPayment: const SettlementPayment(
        id: 81,
        amount: 15000,
        status: PaymentStatus.unpaid,
      ),
      summary: const SettlementSummary(
        totalCount: 1,
        unpaidCount: 1,
        pendingCount: 0,
        paidCount: 0,
        refundedCount: 0,
        paidAmount: 0,
      ),
      payments: const [
        SettlementPayment(
          id: 81,
          memberId: 3,
          userName: '김모아',
          amount: 15000,
          status: PaymentStatus.unpaid,
        ),
      ],
    );

    Future<void> open(
      WidgetTester tester, {
      required Future<MemberRole> Function() role,
      SettlementDetail? value,
    }) async {
      tester.view.physicalSize = const Size(393, 852);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            groupMyRoleProvider.overrideWith((ref, id) => role()),
            settlementDetailProvider.overrideWith(
              (ref, key) async => value ?? detail,
            ),
          ],
          child: const MaterialApp(
            home: SettlementDetailPage(meetingId: 7, settlementId: 40),
          ),
        ),
      );
    }

    testWidgets('관리자도 정산 대상이면 본인 납부 동작을 사용할 수 있다', (tester) async {
      await open(tester, role: () async => MemberRole.admin);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.text('납부했어요'), 180);
      expect(find.text('납부했어요'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('이전 권한이 남아 있어도 재조회 중에는 구성원 납부를 숨긴다', (tester) async {
      final retry = Completer<MemberRole>();
      var calls = 0;
      await open(
        tester,
        role: () {
          calls++;
          return calls == 1 ? Future.value(MemberRole.member) : retry.future;
        },
      );
      await tester.pumpAndSettle();
      expect(find.text('납부했어요'), findsOneWidget);
      final container = ProviderScope.containerOf(
        tester.element(find.byType(SettlementDetailPage)),
      );
      container.invalidate(groupMyRoleProvider(7));
      await tester.pump();
      expect(find.text('납부했어요'), findsNothing);
      retry.complete(MemberRole.member);
      await tester.pumpAndSettle();
      expect(find.text('납부했어요'), findsOneWidget);
    });
    testWidgets('권한 조회 중에는 구성원 납부 동작을 노출하지 않는다', (tester) async {
      final role = Completer<MemberRole>();
      await open(tester, role: () => role.future);
      await tester.pump();
      expect(find.text('납부했어요'), findsNothing);
      role.complete(MemberRole.admin);
      await tester.pumpAndSettle();
      expect(find.text('정산 현황'), findsOneWidget);
    });

    testWidgets('정산 대상이 아니면 0원 청구처럼 표시하지 않는다', (tester) async {
      await open(
        tester,
        role: () async => MemberRole.member,
        value: detail.copyWith(myPayment: null),
      );
      await tester.pumpAndSettle();
      expect(find.text('정산 대상이 아니에요'), findsOneWidget);
      expect(find.text('납부했어요'), findsNothing);
    });
  });
}
