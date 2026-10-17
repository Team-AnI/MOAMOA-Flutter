import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'group_list_preferences.dart';

class GroupListPreferencesViewModel extends Notifier<GroupListPreferences> {
  @override
  GroupListPreferences build() => const GroupListPreferences();

  void togglePin(int id) => state = state.copyWith(
    pinnedIds: state.pinnedIds.contains(id)
        ? state.pinnedIds.where((value) => value != id).toList()
        : [...state.pinnedIds, id],
  );

  void toggleArchive(int id) => state = state.copyWith(
    archivedIds: state.archivedIds.contains(id)
        ? state.archivedIds.where((value) => value != id).toList()
        : [...state.archivedIds, id],
  );

  /// 섹션 안에서 변경한 순서를 다른 섹션의 순서와 합칩니다.
  void reorder(List<int> ids) => state = state.copyWith(
    orderedIds: [...state.orderedIds.where((id) => !ids.contains(id)), ...ids],
  );
}
