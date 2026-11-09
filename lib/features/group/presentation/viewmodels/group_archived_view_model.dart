import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/current_group.dart';
import '../providers/group_list_preferences_provider.dart';

/// 화면 안에서 마지막으로 복원한 모임 이름을 관리합니다.
class GroupArchivedViewModel extends Notifier<String?> {
  @override
  String? build() => null;

  void restore(CurrentGroup current) {
    final id = current.group.id;
    if (!ref.read(groupListPreferencesProvider).archivedIds.contains(id)) {
      return;
    }
    ref.read(groupListPreferencesProvider.notifier).toggleArchive(id);
    state = current.group.name;
  }
}
