import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/notice.dart';
import '../../domain/entities/notice_detail_request.dart';
import '../../domain/usecases/get_notice_detail.dart';
import '../providers/notice_providers.dart';

/// 공지 상세 ViewModel
class NoticeDetailViewModel extends AsyncNotifier<Notice> {
  NoticeDetailViewModel({required NoticeDetailRequest request})
    : _request = request;

  final NoticeDetailRequest _request;

  @override
  Future<Notice> build() {
    return ref.watch(getNoticeDetailProvider)(
      GetNoticeDetailParams(
        meetingId: _request.meetingId,
        noticeId: _request.noticeId,
      ),
    );
  }
}
