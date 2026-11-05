import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_archived_provider.dart';
import 'package:moamoa/features/group/presentation/providers/group_list_preferences_provider.dart';

import '../../fake_group_repository.dart';

void main() {
  test('연속 복원은 마지막 이름을 표시하고 중복 요청은 다시 보관하지 않는다', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final subscription = container.listen(groupArchivedProvider, (_, _) {});
    addTearDown(subscription.close);
    final first = makeGroup(MemberRole.member);
    final second = first.copyWith(
      group: first.group.copyWith(id: 2, name: '두 번째 모임'),
      membership: first.membership.copyWith(groupId: 2),
    );
    final preferences = container.read(groupListPreferencesProvider.notifier);
    preferences.toggleArchive(first.group.id);
    preferences.toggleArchive(second.group.id);
    final viewModel = container.read(groupArchivedProvider.notifier);

    viewModel.restore(first);
    expect(container.read(groupArchivedProvider), first.group.name);
    expect(container.read(groupListPreferencesProvider).archivedIds, [2]);
    viewModel.restore(second);
    viewModel.restore(second);
    expect(container.read(groupArchivedProvider), '두 번째 모임');
    expect(container.read(groupListPreferencesProvider).archivedIds, isEmpty);
  });

  test('화면 구독 종료 후 안내만 초기화하고 표시 설정은 유지한다', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final current = makeGroup(MemberRole.member);
    final preferences = container.read(groupListPreferencesProvider.notifier);
    preferences.toggleArchive(current.group.id);
    preferences.togglePin(current.group.id);
    preferences.reorder([current.group.id]);
    final subscription = container.listen(groupArchivedProvider, (_, _) {});
    container.read(groupArchivedProvider.notifier).restore(current);
    final settings = container.read(groupListPreferencesProvider);
    subscription.close();
    await container.pump();

    final reopened = container.listen(groupArchivedProvider, (_, _) {});
    addTearDown(reopened.close);
    expect(container.read(groupArchivedProvider), isNull);
    expect(container.read(groupListPreferencesProvider), settings);
  });
}
