import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/create_notice.dart';
import '../../domain/usecases/update_notice.dart';
import '../providers/notice_providers.dart';

/// 공지 작성 / 수정 ViewModel (family 인자: meetingId)
///
/// 상태는 등록 요청의 진행 상황입니다. (대기 / 등록 중 / 실패)
class NoticeWriteViewModel extends AsyncNotifier<void> {
  NoticeWriteViewModel(this._meetingId);

  final int _meetingId;

  @override
  FutureOr<void> build() {}

  /// [noticeId] 가 없으면 작성, 있으면 수정합니다.
  ///
  /// 성공하면 true 를 반환하고 목록(수정이면 상세도)을 다시 불러옵니다.
  /// 실패하면 false 를 반환하고, 상태의 error 에 원인이 담깁니다.
  Future<bool> submit({
    int? noticeId,
    required String title,
    required String content,
  }) async {
    if (state.isLoading) return false;

    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      if (noticeId == null) {
        await ref.read(createNoticeProvider)(
          CreateNoticeParams(
            meetingId: _meetingId,
            title: title,
            content: content,
          ),
        );
      } else {
        await ref.read(updateNoticeProvider)(
          UpdateNoticeParams(
            meetingId: _meetingId,
            noticeId: noticeId,
            title: title,
            content: content,
          ),
        );
      }
    });
    if (!ref.mounted) return false;
    state = result;
    if (result.hasError) return false;

    ref.invalidate(noticeListProvider(_meetingId));
    if (noticeId != null) {
      ref.invalidate(
        noticeDetailProvider((meetingId: _meetingId, noticeId: noticeId)),
      );
    }
    return true;
  }
}
