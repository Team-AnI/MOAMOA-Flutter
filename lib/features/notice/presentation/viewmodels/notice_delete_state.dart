import 'package:freezed_annotation/freezed_annotation.dart';

import 'notice_delete_status.dart';

part 'notice_delete_state.freezed.dart';

/// 공지 삭제 상태. 현재 단계와 실패 원인을 담습니다.
@freezed
abstract class NoticeDeleteState with _$NoticeDeleteState {
  const factory NoticeDeleteState({
    @Default(NoticeDeleteStatus.initial) NoticeDeleteStatus status,

    /// [status] 가 failure 일 때만 값이 있습니다.
    Object? error,
  }) = _NoticeDeleteState;
}

extension NoticeDeleteStateX on NoticeDeleteState {
  bool get isDeleting => status == NoticeDeleteStatus.deleting;
}
