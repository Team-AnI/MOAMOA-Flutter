import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/app/app.dart';
import 'package:moamoa/features/group/data/repositories/memory_group_repository.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';

void main() {
  late ProviderContainer container;
  setUp(() {
    container = ProviderContainer(
      overrides: [groupUseMockProvider.overrideWithValue(true)],
    );
  });
  tearDown(() => container.dispose());

  test('Mock 모드는 API 대신 메모리 데이터를 사용하고 생성 결과를 다시 조회한다', () async {
    expect(
      container.read(groupRepositoryProvider),
      isA<MemoryGroupRepository>(),
    );
    expect(container.read(groupCurrentUserNameProvider), '테스트 사용자');
    final vm = container.read(groupProvider.notifier);
    await vm.loadGroups();
    expect(container.read(groupProvider).groups, isEmpty);
    final created = (await vm.create(name: ' 스터디 ', description: ' 소개 '))!;
    expect(created.membership.role, MemberRole.admin);
    expect(created.group.name, '스터디');
    expect(created.group.description, '소개');
    expect(
      await container
          .read(groupRepositoryProvider)
          .getInviteCode(groupId: created.group.id),
      startsWith('MOA-'),
    );
    await vm.loadGroups();
    expect(container.read(groupProvider).groups.single, created);
    await vm.selectGroup(created.group.id);
    expect(container.read(groupProvider).currentGroup, created);
  });

  test('Mock 가입은 MEMBER를 부여하고 잘못된 코드·재가입·권한 오류를 구분한다', () async {
    final vm = container.read(groupProvider.notifier);
    expect(await vm.join('WRONG'), isNull);
    expect(
      container.read(groupProvider).failureReason,
      GroupFailureReason.invalidCode,
    );
    final joined = (await vm.join(' MOA-JOIN '))!;
    expect(joined.membership.role, MemberRole.member);
    expect(joined.canViewInviteCode, isFalse);
    expect(joined.group.memberCount, 2);
    expect(await vm.join('MOA-JOIN'), isNull);
    expect(
      container.read(groupProvider).failureReason,
      GroupFailureReason.alreadyJoined,
    );
    await vm.loadGroups();
    expect(container.read(groupProvider).groups, hasLength(1));
    await expectLater(
      container
          .read(groupRepositoryProvider)
          .getInviteCode(groupId: joined.group.id),
      throwsA(
        isA<GroupFailure>().having(
          (e) => e.reason,
          'reason',
          GroupFailureReason.forbidden,
        ),
      ),
    );
  });

  test('새 Mock Repository는 초기 상태로 돌아간다', () async {
    final repository = MemoryGroupRepository();
    await repository.createGroup(name: '모임', description: '');
    expect(await MemoryGroupRepository().getMyGroups(), isEmpty);
  });

  testWidgets('Mock 실행 화면에서 실제 Repository로 생성 완료까지 이동한다', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [groupUseMockProvider.overrideWithValue(true)],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('내 모임'));
    await tester.pumpAndSettle();
    expect(find.text('요청을 완료하지 못했습니다. 다시 시도해주세요.'), findsNothing);
    await tester.tap(find.text('모임 만들기'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Mock 스터디');
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    expect(find.text('관리자 · 테스트 사용자'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, '모임 만들기'));
    await tester.pumpAndSettle();
    expect(find.textContaining('만들어졌어요'), findsOneWidget);
    expect(find.text('MOA-000002'), findsOneWidget);
    await tester.tap(find.text('내 모임으로'));
    await tester.pumpAndSettle();
    expect(find.text('내 모임'), findsOneWidget);
    expect(find.text('Mock 스터디'), findsOneWidget);
  });
  testWidgets('Mock 미리보기는 가입하지 않고 확인 후에만 가입한다', (tester) async {
    final repository = MemoryGroupRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          groupUseMockProvider.overrideWithValue(true),
          groupRepositoryProvider.overrideWithValue(repository),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('내 모임'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('초대 코드로 가입'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'WRONG');
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    expect(find.text('초대 코드를 확인해주세요.'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'MOA-JOIN');
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    expect(find.text('이 모임에 가입할까요?'), findsOneWidget);
    expect(await repository.getMyGroups(), isEmpty);
    await tester.tap(find.byTooltip('뒤로'));
    await tester.pumpAndSettle();
    expect(find.text('MOA-JOIN'), findsOneWidget);
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('가입하기'));
    await tester.pumpAndSettle();
    expect(find.text('모임에 가입했어요'), findsOneWidget);
    expect(find.text('가입 완료'), findsOneWidget);
    expect((await repository.getMyGroups()).single.group.memberCount, 2);
    await tester.tap(find.text('내 모임으로'));
    await tester.pumpAndSettle();
    expect(find.text('초대받은 스터디'), findsOneWidget);
  });
}
