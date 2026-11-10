import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/notice.dart';
import '../../domain/usecases/get_notice_detail.dart';
import '../providers/notice_providers.dart';

/// 공지 상세 · 삭제의 family 인자
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
}
