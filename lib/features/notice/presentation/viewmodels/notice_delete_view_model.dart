import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/delete_notice.dart';
import '../providers/notice_providers.dart';
import 'notice_delete_state.dart';
import 'notice_delete_status.dart';
import 'notice_detail_view_model.dart';

/// 공지 삭제 ViewModel (family 인자: 상세와 같은 [NoticeDetailArgs])
///
/// 삭제 결과는 반환하지 않고 [NoticeDeleteState] 의 단계로 알립니다.
class NoticeDeleteViewModel extends Notifier<NoticeDeleteState> {
  NoticeDeleteViewModel({required NoticeDetailArgs args}) : _args = args;

  final NoticeDetailArgs _args;

  @override
  NoticeDeleteState build() => const NoticeDeleteState();

  /// 공지를 삭제하고 목록을 다시 불러옵니다.
  ///
  /// 요청 중에 화면이 닫혀도 provider 를 살려 두어, 삭제된 공지가 목록에 남지 않도록
  /// 끝까지 처리합니다.
  Future<void> delete() async {
    if (state.isDeleting) return; // 중복 요청 방지
    state = const NoticeDeleteState(status: NoticeDeleteStatus.deleting);

    final keepAlive = ref.keepAlive();
    try {
      await ref.read(deleteNoticeProvider)(
        DeleteNoticeParams(
          meetingId: _args.meetingId,
          noticeId: _args.noticeId,
        ),
      );
      ref.invalidate(noticeListProvider(_args.meetingId));
      state = const NoticeDeleteState(status: NoticeDeleteStatus.success);
    } catch (error) {
      state = NoticeDeleteState(
        status: NoticeDeleteStatus.failure,
        error: error,
      );
    } finally {
      keepAlive.close();
    }
  }
}
