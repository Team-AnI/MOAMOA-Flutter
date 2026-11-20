import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_members_providers.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_members_state.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_members_view_model.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';
import 'package:moamoa/features/settlement/domain/repositories/settlement_repository.dart';
import 'package:moamoa/features/settlement/presentation/providers/settlement_providers.dart';

class TestMembers extends GroupMembersViewModel {
  TestMembers() : super(groupId: 7);
  @override
  GroupMembersState build() => const GroupMembersState(hasLoaded: true);
}

class TestSettlementRepository implements SettlementRepository {
  int mutations = 0;
  @override
  dynamic noSuchMethod(Invocation invocation) {
    mutations++;
    throw UnimplementedError(invocation.memberName.toString());
  }
}

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
Future<void> pumpReviewPage(
  WidgetTester tester,
  Widget page, {
  bool roleFails = false,
  MemberRole role = MemberRole.admin,
  SettlementDetail? value,
  TestSettlementRepository? repository,
  ValueNotifier<bool>? visible,
  GlobalKey<NavigatorState>? navigator,
  void Function()? onRoleRequest,
}) async {
  tester.view.physicalSize = const Size(393, 852);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  var failed = false;
  await tester.pumpWidget(
    ProviderScope(
      retry: (_, _) => null,
      overrides: [
        groupMyRoleProvider.overrideWith((ref, id) async {
          onRoleRequest?.call();
          if (roleFails && !failed) {
            failed = true;
            throw Exception('offline');
          }
          return role;
        }),
        groupMembersProvider(7).overrideWith(TestMembers.new),
        settlementDetailProvider.overrideWith(
          (ref, key) async => value ?? detail,
        ),
        if (repository != null)
          settlementRepositoryProvider.overrideWithValue(repository),
      ],
      child: MaterialApp(
        navigatorKey: navigator,
        home: visible == null
            ? page
            : ValueListenableBuilder<bool>(
                valueListenable: visible,
                builder: (_, show, _) => show ? page : const SizedBox(),
              ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
