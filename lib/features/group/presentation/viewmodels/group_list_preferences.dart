import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/current_group.dart';

part 'group_list_preferences.freezed.dart';

/// 서버의 가입 상태와 독립적인, 현재 앱 실행 중의 목록 표시 설정입니다.
@freezed
abstract class GroupListPreferences with _$GroupListPreferences {
  const factory GroupListPreferences({
    @Default([]) List<int> pinnedIds,
    @Default([]) List<int> archivedIds,
    @Default([]) List<int> orderedIds,
  }) = _GroupListPreferences;
}

extension GroupListPreferencesX on GroupListPreferences {
  List<CurrentGroup> arrange(
    Iterable<CurrentGroup> groups, {
    bool pinnedFirst = true,
  }) {
    final result = groups.toList();
    final positions = <int, int>{
      for (var i = 0; i < result.length; i++)
        result[i].group.id: orderedIds.length + i,
      for (var i = 0; i < orderedIds.length; i++) orderedIds[i]: i,
    };
    result.sort((a, b) {
      final aPinned = pinnedIds.contains(a.group.id);
      final bPinned = pinnedIds.contains(b.group.id);
      if (pinnedFirst && aPinned != bPinned) return aPinned ? -1 : 1;
      return positions[a.group.id]!.compareTo(positions[b.group.id]!);
    });
    return result;
  }
}
