import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/group_list_preferences.dart';
import '../viewmodels/group_list_preferences_view_model.dart';

final groupListPreferencesProvider =
    NotifierProvider<GroupListPreferencesViewModel, GroupListPreferences>(
      GroupListPreferencesViewModel.new,
    );
