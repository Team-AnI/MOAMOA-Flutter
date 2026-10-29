import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/current_group.dart';
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

  /// SDK가 보정한 newIndex를 그대로 사용하고, 다른 역할의 순서는 보존합니다.
  void reorderSection(List<CurrentGroup> groups, int oldIndex, int newIndex) {
    final reordered = [...groups];
    reordered.insert(newIndex, reordered.removeAt(oldIndex));
    reorder(reordered.map((current) => current.group.id).toList());
  }
}
