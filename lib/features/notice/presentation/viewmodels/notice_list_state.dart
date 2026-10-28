import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notice.dart';

part 'notice_list_state.freezed.dart';

/// 공지 목록 화면 상태
@freezed
abstract class NoticeListState with _$NoticeListState {
  const factory NoticeListState({
    /// 지금까지 불러온 공지 (최신순)
    required List<Notice> notices,

    /// 마지막으로 불러온 페이지 번호 (0부터 시작)
    required int page,
    required bool hasNext,

    /// 다음 페이지를 불러오는 중인지
    @Default(false) bool isLoadingMore,
  }) = _NoticeListState;
}

extension NoticeListStateX on NoticeListState {
  bool get isEmpty => notices.isEmpty;
}
