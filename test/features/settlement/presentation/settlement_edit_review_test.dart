import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';
import 'package:moamoa/features/settlement/presentation/pages/settlement_edit_page.dart';
import 'package:moamoa/features/settlement/presentation/pages/settlement_detail_page.dart';

import 'settlement_review_test_support.dart';

void main() {
  final pages = <String, Widget>{
    '정산 수정': const SettlementEditPage(meetingId: 7, settlementId: 40),
  };
  for (final entry in pages.entries) {
    testWidgets('${entry.key}: 권한 조회 실패 후 다시 시도하면 관리자 화면을 연다', (tester) async {
      var requests = 0;
      await pumpReviewPage(
        tester,
        entry.value,
        roleFails: true,
        onRoleRequest: () => requests++,
      );
      expect(find.textContaining('관리자만'), findsNothing);
      await tester.tap(find.text('권한 정보를 불러오지 못했어요. 다시 시도'));
      await tester.pumpAndSettle();
      expect(requests, 2);
      expect(find.text('권한 정보를 불러오지 못했어요. 다시 시도'), findsNothing);
      expect(find.byType(Form), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
    testWidgets('${entry.key}: 일반 구성원은 권한 안내를 보고 폼을 사용하지 못한다', (tester) async {
      await pumpReviewPage(tester, entry.value, role: MemberRole.member);
      expect(find.textContaining('관리자만'), findsOneWidget);
      expect(find.byType(Form), findsNothing);
    });
  }

  for (final scenario in [
    ('취소', '정산 취소', '정산 취소', detail),
    (
      '환불',
      '환불 완료 기록',
      '환불 완료 기록',
      detail.copyWith(
        status: SettlementStatus.canceled,
        payments: [detail.payments.single.copyWith(status: PaymentStatus.paid)],
      ),
    ),
  ]) {
    testWidgets('${scenario.$1}: 확인 창을 띄운 뒤 원래 화면이 닫히면 서버 요청을 보내지 않는다', (
      tester,
    ) async {
      final visible = ValueNotifier(true);
      addTearDown(visible.dispose);
      final repository = TestSettlementRepository();
      await pumpReviewPage(
        tester,
        const SettlementDetailPage(meetingId: 7, settlementId: 40),
        visible: visible,
        repository: repository,
        value: scenario.$4,
      );
      await tester.scrollUntilVisible(
        find.text(scenario.$2),
        180,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text(scenario.$2).first);
      await tester.pumpAndSettle();
      visible.value = false;
      await tester.pump();
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text(scenario.$3),
        ),
      );
      await tester.pumpAndSettle();
      expect(repository.mutations, 0);
      expect(tester.takeException(), isNull);
    });
  }

  for (final entry in [
    (
      '수정 기한',
      const SettlementEditPage(meetingId: 7, settlementId: 40),
      find.text('납부 기한'),
      false,
    ),
  ]) {
    testWidgets('${entry.$1}: 선택 창이 열린 동안 화면이 닫혀도 안전하다', (tester) async {
      final visible = ValueNotifier(true);
      addTearDown(visible.dispose);
      final navigator = GlobalKey<NavigatorState>();
      await pumpReviewPage(
        tester,
        entry.$2,
        visible: visible,
        navigator: navigator,
      );
      await tester.scrollUntilVisible(
        entry.$3,
        180,
        scrollable: find.byType(Scrollable).first,
      );
      await Scrollable.ensureVisible(tester.element(entry.$3), alignment: 0.5);
      await tester.pumpAndSettle();
      await tester.tap(entry.$3);
      await tester.pumpAndSettle();
      expect(
        find.byType(entry.$4 ? TimePickerDialog : DatePickerDialog),
        findsOneWidget,
      );
      visible.value = false;
      await tester.pump();
      navigator.currentState!.pop(
        entry.$4
            ? const TimeOfDay(hour: 10, minute: 30)
            : DateTime(2026, 11, 18),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
