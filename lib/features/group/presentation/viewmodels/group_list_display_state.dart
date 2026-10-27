import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/current_group.dart';
import 'group_list_preferences.dart';
import 'group_state.dart';

part 'group_list_display_state.freezed.dart';

/// 서버 상태와 로컬 표시 설정을 합성합니다. 원본 상태는 변경하지 않습니다.
@freezed
abstract class GroupListDisplayState with _$GroupListDisplayState {
  const GroupListDisplayState._();
  const factory GroupListDisplayState({
    required GroupState source,
    required GroupListPreferences preferences,
    String? userName,
  }) = _GroupListDisplayState;

  String get greeting {
    final name = userName?.trim();
    return name == null || name.isEmpty ? '안녕하세요' : '$name님, 안녕하세요';
  }

  List<CurrentGroup> get visibleGroups => preferences.arrange(
    source.groups.where((group) => !isArchived(group.group.id)),
  );
  List<CurrentGroup> get adminGroups => _role(visibleGroups, admin: true);
  List<CurrentGroup> get memberGroups => _role(visibleGroups, admin: false);

  // 관리 화면은 고정 여부와 무관하게 사용자가 지정한 순서로 표시합니다.
  List<CurrentGroup> get manageGroups => preferences.arrange(
    source.groups.where((group) => !isArchived(group.group.id)),
    pinnedFirst: false,
  );
  List<CurrentGroup> get manageAdminGroups => _role(manageGroups, admin: true);
  List<CurrentGroup> get manageMemberGroups =>
      _role(manageGroups, admin: false);
  List<CurrentGroup> get archivedGroups => preferences.arrange(
    source.groups.where((group) => isArchived(group.group.id)),
    pinnedFirst: false,
  );
  List<CurrentGroup> get archivedAdminGroups =>
      _role(archivedGroups, admin: true);
  List<CurrentGroup> get archivedMemberGroups =>
      _role(archivedGroups, admin: false);
  int get archivedCount => archivedGroups.length;
  bool get hasGroups => source.groups.isNotEmpty;
  bool get showEmpty =>
      !source.isLoading && !hasGroups && source.errorMessage == null;
  bool get showAllArchived =>
      !source.isLoading &&
      hasGroups &&
      visibleGroups.isEmpty &&
      source.errorMessage == null;
  double get memberSectionPadding => adminGroups.isEmpty ? 20 : 24;
  double get manageMemberSectionPadding => manageAdminGroups.isEmpty ? 4 : 16;
  double get archivedMemberSectionPadding =>
      archivedAdminGroups.isEmpty ? 4 : 16;

  bool get isManageEmpty => manageGroups.isEmpty;
  bool get isArchiveEmpty => archivedGroups.isEmpty;
  String menuSubtitle(CurrentGroup current) => [
    current.canViewInviteCode ? '관리자' : '구성원',
    if (current.group.memberCount != null) '구성원 ${current.group.memberCount}명',
  ].join(' · ');

  bool isPinned(int id) => preferences.pinnedIds.contains(id);
  bool isArchived(int id) => preferences.archivedIds.contains(id);
  List<CurrentGroup> _role(List<CurrentGroup> groups, {required bool admin}) =>
      List.unmodifiable(
        groups.where((group) => group.canViewInviteCode == admin),
      );
}
