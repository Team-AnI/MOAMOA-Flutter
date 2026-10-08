import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/group_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_notifier.dart';

import '../fake_group_repository.dart';

void main() {
  late FakeGroupRepository repository;
  late ProviderContainer container;
  setUp(() {
    repository = FakeGroupRepository();
    container = ProviderContainer(
      overrides: [groupRepositoryProvider.overrideWithValue(repository)],
    );
  });
  tearDown(() => container.dispose());

  test('내 모임 목록을 불러오고 선택한 모임이 삭제되면 선택을 해제한다', () async {
    final group = makeGroup(GroupRole.admin);
    repository.groups = [group];
    final notifier = container.read(groupProvider.notifier);
    await notifier.loadGroups();
    await notifier.selectGroup(group.group.id);
    expect(container.read(groupProvider).currentGroup, same(group));
    repository.groups = [];
    await notifier.loadGroups();
    expect(container.read(groupProvider).groups, isEmpty);
    expect(container.read(groupProvider).currentGroup, isNull);
  });

  test('목록 로딩 실패 시 기존 모임 정보를 보존한다', () async {
    final group = makeGroup(GroupRole.member);
    repository.groups = [group];
    final notifier = container.read(groupProvider.notifier);
    await notifier.loadGroups();
    await notifier.selectGroup(group.group.id);
    repository.loadFailure = const GroupFailure(GroupFailureReason.unavailable);
    await notifier.loadGroups();
    expect(container.read(groupProvider).currentGroup, same(group));
    expect(container.read(groupProvider).groups, contains(group));
    expect(container.read(groupProvider).isLoading, isFalse);
    expect(container.read(groupProvider).errorMessage, isNotNull);
  });

  test('필수 입력이 비어 있으면 저장소를 호출하지 않는다', () async {
    final result = await container
        .read(groupProvider.notifier)
        .create(name: ' ', description: '소개');
    expect(result, isNull);
    expect(repository.createCalls, 0);
    expect(container.read(groupProvider).errorMessage, isNotNull);
  });

  test('생성 중 중복 요청을 막고 성공한 모임을 선택한다', () async {
    final notifier = container.read(groupProvider.notifier);
    final first = notifier.create(name: ' 모임 ', description: ' 소개 ');
    expect(container.read(groupProvider).isSubmitting, isTrue);
    expect(await notifier.create(name: '모임', description: '소개'), isNull);
    expect(repository.createCalls, 1);
    expect(repository.lastName, '모임');
    expect(repository.lastDescription, '소개');
    final group = makeGroup(GroupRole.admin);
    repository.pendingCreate.complete(group);
    expect(await first, same(group));
    expect(container.read(groupProvider).currentGroup, same(group));
    expect(container.read(groupProvider).groups, contains(group));
    expect(container.read(groupProvider).isSubmitting, isFalse);
  });

  for (final reason in [
    GroupFailureReason.invalidCode,
    GroupFailureReason.alreadyJoined,
  ]) {
    test('가입 실패 $reason 시 현재 모임을 변경하지 않는다', () async {
      repository.joinFailure = GroupFailure(reason);
      expect(await container.read(groupProvider.notifier).join('CODE'), isNull);
      expect(container.read(groupProvider).currentGroup, isNull);
      expect(container.read(groupProvider).errorMessage, isNotNull);
      expect(container.read(groupProvider).isSubmitting, isFalse);
    });
  }

  test('가입 성공 시 일반 구성원 모임을 선택한다', () async {
    await container.read(groupProvider.notifier).join('CODE');
    expect(
      container.read(groupProvider).currentGroup!.canViewInviteCode,
      isFalse,
    );
  });
}
