import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/group_list_display_state.dart';
import '../viewmodels/group_list_preferences.dart';
import '../viewmodels/group_list_preferences_view_model.dart';
import 'group_providers.dart';

final groupListPreferencesProvider =
    NotifierProvider<GroupListPreferencesViewModel, GroupListPreferences>(
      GroupListPreferencesViewModel.new,
    );

/// 원본 모임과 표시 설정의 변경을 함께 반영하는 읽기 전용 화면 상태입니다.
final groupListDisplayProvider = Provider<GroupListDisplayState>(
  (ref) => GroupListDisplayState(
    source: ref.watch(groupProvider),
    preferences: ref.watch(groupListPreferencesProvider),
    userName: ref.watch(groupCurrentUserNameProvider),
  ),
);
