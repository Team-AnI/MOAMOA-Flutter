import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/notice.dart';
import '../../domain/usecases/delete_notice.dart';
import '../../domain/usecases/get_notice_detail.dart';
import '../../domain/usecases/set_notice_pinned.dart';
import '../providers/notice_providers.dart';

/// 공지 상세 화면의 family 인자
typedef NoticeDetailArgs = ({int meetingId, int noticeId});

/// 공지 상세 ViewModel
class NoticeDetailViewModel extends AsyncNotifier<Notice> {
  NoticeDetailViewModel(this._args);

  final NoticeDetailArgs _args;

  @override
  Future<Notice> build() {
    return ref.watch(getNoticeDetailProvider)(
      GetNoticeDetailParams(
        meetingId: _args.meetingId,
        noticeId: _args.noticeId,
      ),
    );
  }

  /// 공지를 삭제하고 목록을 다시 불러옵니다. 실패하면 NoticeException 을 던집니다.
  Future<void> delete() async {
    await ref.read(deleteNoticeProvider)(
      DeleteNoticeParams(meetingId: _args.meetingId, noticeId: _args.noticeId),
    );
    ref.invalidate(noticeListProvider(_args.meetingId));
  }

  /// 고정 ↔ 고정 해제. 실패하면 NoticeException 을 던집니다.
  Future<void> togglePin() async {
    final notice = state.value;
    if (notice == null) return;

    await ref.read(setNoticePinnedProvider)(
      SetNoticePinnedParams(
        meetingId: _args.meetingId,
        noticeId: _args.noticeId,
        pinned: !notice.isPinned,
      ),
    );
    ref.invalidateSelf();
    ref.invalidate(noticeListProvider(_args.meetingId));
  }
}
