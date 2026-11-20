import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_members_providers.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_members_state.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';
import 'package:moamoa/features/settlement/presentation/pages/settlement_edit_page.dart';
import 'package:moamoa/features/settlement/presentation/providers/settlement_providers.dart';
import 'package:moamoa/features/settlement/presentation/settlement_edit_changes.dart';

import 'settlement_review_test_support.dart' as support;

class _Members extends support.TestMembers {
  _Members(this.onRequest);
  final VoidCallback onRequest;
  @override
  GroupMembersState build() {
    onRequest();
    return super.build();
  }
}

void main() {
  group(SettlementEditPage, () {
    for (final state in ['loading', 'member', 'error']) {
      testWidgets('$state 권한에서는 구성원과 정산을 조회하지 않는다', (tester) async {
        final response = Completer<MemberRole>();
        var members = 0, details = 0;
        await tester.pumpWidget(
          ProviderScope(
            retry: (_, _) => null,
            overrides: [
              groupMyRoleProvider.overrideWith((ref, id) => response.future),
              groupMembersProvider(7)
                  .overrideWith(() => _Members(() => members++)),
              settlementDetailProvider.overrideWith((ref, key) async {
                details++;
                return support.detail;
              }),
            ],
            child: const MaterialApp(
              home: SettlementEditPage(meetingId: 7, settlementId: 40),
            ),
          ),
        );
        if (state == 'member') {
          response.complete(MemberRole.member);
        } else if (state == 'error') {
          response.completeError(Exception('offline'));
        }
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 20));
        expect(members, 0);
        expect(details, 0);
        expect(find.byType(Form), findsNothing);
        if (state == 'loading') {
          response.complete(MemberRole.admin);
          await tester.pumpAndSettle();
          expect(members, 1);
          expect(details, 1);
          expect(find.byType(Form), findsOneWidget);
        }
        expect(tester.takeException(), isNull);
      });
    }
  });
  group(SettlementEditInput, () {
    test('대상 순서와 같은 시각의 시간대 차이는 수정 사항으로 보내지 않는다', () {
      final previous = support.detail.copyWith(
        payments: [
          support.detail.payments.first,
          support.detail.payments.first.copyWith(id: 82, memberId: 5),
        ],
      );
      final input = SettlementEditInput(
        title: previous.title,
        totalAmount: previous.totalAmount,
        memberIds: [5, 3],
        bankName: previous.bankName,
        accountNumber: previous.accountNumber,
        accountHolder: previous.accountHolder,
        dueAt: previous.dueAt.toUtc(),
      );
      expect(input.changesFrom(previous).isEmpty, isTrue);
    });
    test('바뀐 대상과 명시적인 일정 연결 해제만 변경 값에 담는다', () {
      final previous = support.detail.copyWith(scheduleId: 20);
      final changes = const SettlementEditInput(
        title: '새 정산',
        memberIds: [7, 3],
        unlinkSchedule: true,
      ).changesFrom(previous);
      expect(changes.title, '새 정산');
      expect(changes.memberIds, [3, 7]);
      expect(changes.unlinkSchedule, isTrue);
      expect(changes.totalAmount, isNull);
      expect(changes.isEmpty, isFalse);
    });
    test('연결된 일정이 없으면 해제 요청을 만들지 않는다', () {
      expect(
        const SettlementEditInput(unlinkSchedule: true)
            .changesFrom(support.detail)
            .isEmpty,
        isTrue,
      );
    });
  });
}
