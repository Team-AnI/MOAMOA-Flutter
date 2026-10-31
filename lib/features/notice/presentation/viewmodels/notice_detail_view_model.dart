import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/notice.dart';
import '../../domain/usecases/delete_notice.dart';
import '../../domain/usecases/get_notice_detail.dart';
import '../providers/notice_providers.dart';

/// 공지 상세 화면의 family 인자
typedef NoticeDetailArgs = ({int meetingId, int noticeId});

/// 공지 상세 ViewModel
class NoticeDetailViewModel extends AsyncNotifier<Notice> {
  NoticeDetailViewModel({required NoticeDetailArgs args}) : _args = args;

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
  ///
  /// 요청 중에 화면이 닫혀도 provider 를 살려 두어, 삭제된 공지가 목록에 남지 않도록
  /// 끝까지 처리합니다.
  Future<void> delete() async {
    final keepAlive = ref.keepAlive();
    try {
      await ref.read(deleteNoticeProvider)(
        DeleteNoticeParams(
          meetingId: _args.meetingId,
          noticeId: _args.noticeId,
        ),
      );
      ref.invalidate(noticeListProvider(_args.meetingId));
    } finally {
      keepAlive.close();
    }
  }
}
