import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/group.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/pages/group_home_page.dart';
import 'package:moamoa/features/group/presentation/pages/group_invite_page.dart';
import 'package:moamoa/features/group/presentation/pages/group_list_manage_page.dart';
import 'package:moamoa/features/group/presentation/pages/group_list_page.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/group/presentation/widgets/group_join_summary.dart';

import '../fake_group_repository.dart';

class _InviteRepository extends FakeGroupRepository {
  _InviteRepository(this.code);
  final String code;

  @override
  Future<String> getInviteCode({required int groupId}) async => code;
}

void main() {
  for (final count in <num?>[null, -1, 1.5, 0, 8]) {
    for (final page in ['목록', '홈', '관리', '가입 요약']) {
      testWidgets('$page 화면에서 구성원 수 $count의 표시를 판단한다', (tester) async {
        tester.view.physicalSize = const Size(393, 852);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final group = makeGroup(MemberRole.admin).copyWith(
          group: Group(id: 1, name: '테스트 모임', memberCount: count),
        );
        final repository = FakeGroupRepository()..groups = [group];
        final container = ProviderContainer.test(
          overrides: [groupRepositoryProvider.overrideWithValue(repository)],
        );
        final vm = container.read(groupProvider.notifier);
        await vm.loadGroups();
        await vm.selectGroup(1);
        final widget = switch (page) {
          '목록' => const GroupListPage(),
          '홈' => const GroupHomePage(),
          '관리' => const GroupListManagePage(),
          _ => Scaffold(body: GroupJoinSummary(group: group.group)),
        };
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(home: widget),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.text('테스트 모임'), findsWidgets);
        expect(
          container.read(groupProvider).currentGroup!.group.memberCount,
          count,
        );
        if (count is int && count >= 0) {
          expect(
            find.text(page == '홈' ? '$count명' : '구성원 $count명'),
            findsOneWidget,
          );
        } else {
          expect(find.textContaining(RegExp(r'구성원 .+명')), findsNothing);
          expect(find.textContaining(RegExp(r'-1명|1\.5명')), findsNothing);
        }
      });
    }
  }

  for (final code in ['', '   ', 'CODE']) {
    testWidgets('초대 화면에서 비어 있는 코드의 카드와 복사를 제공하지 않는다 [$code]', (tester) async {
      final repository = _InviteRepository(code)
        ..groups = [makeGroup(MemberRole.admin)];
      final container = ProviderContainer.test(
        overrides: [groupRepositoryProvider.overrideWithValue(repository)],
      );
      await container.read(groupProvider.notifier).selectGroup(1);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: GroupInvitePage()),
        ),
      );
      await tester.pumpAndSettle();
      if (code.trim().isEmpty) {
        expect(find.text('코드 복사'), findsNothing);
        expect(find.text('다시 시도'), findsOneWidget);
        expect(find.text('초대 코드를 불러오지 못했습니다.'), findsOneWidget);
      } else {
        expect(find.text('코드 복사'), findsOneWidget);
        expect(find.text('CODE'), findsOneWidget);
      }
      expect(tester.takeException(), isNull);
    });
  }
}
