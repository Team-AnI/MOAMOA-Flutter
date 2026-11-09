import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/group_archived_view_model.dart';

/// 보관 화면을 떠나면 복원 완료 안내도 함께 정리합니다.
final groupArchivedProvider =
    NotifierProvider.autoDispose<GroupArchivedViewModel, String?>(
      GroupArchivedViewModel.new,
    );
