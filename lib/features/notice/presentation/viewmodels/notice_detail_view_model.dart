import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/notice.dart';
import '../../domain/entities/notice_exception.dart';
import '../../domain/usecases/get_notice_detail.dart';
import '../../domain/usecases/mark_notice_read.dart';
import '../providers/notice_providers.dart';

/// 공지 상세 · 삭제의 family 인자
typedef NoticeDetailArgs = ({int meetingId, int noticeId});

/// 공지 상세 ViewModel
class NoticeDetailViewModel extends AsyncNotifier<Notice> {
  NoticeDetailViewModel({required NoticeDetailArgs args}) : _args = args;

  final NoticeDetailArgs _args;

  /// 이 화면에서 읽음 처리를 이미 요청했는지. 다시 불러와도 한 번만 보냅니다.
  bool _readRequested = false;

  @override
  Future<Notice> build() async {
    final notice = await ref.watch(getNoticeDetailProvider)(
      GetNoticeDetailParams(
        meetingId: _args.meetingId,
        noticeId: _args.noticeId,
      ),
    );
    // 상세를 보여준 뒤 읽음으로 기록합니다. 응답은 기다리지 않습니다. (3-6)
    // 불러오는 사이 화면을 나가 provider 가 정리됐으면 ref 를 쓸 수 없어 보내지 않습니다.
    if (ref.mounted) unawaited(_markRead());
    return notice;
  }

  /// 읽음 처리는 실패해도 상세 화면에 영향이 없도록 오류를 무시합니다.
  /// 서버는 여러 번 호출해도 처음 읽은 시각을 유지하므로 다음에 열 때 다시 기록됩니다.
  Future<void> _markRead() async {
    if (_readRequested) return;
    _readRequested = true;
    try {
      await ref.read(markNoticeReadProvider)(
        MarkNoticeReadParams(
          meetingId: _args.meetingId,
          noticeId: _args.noticeId,
        ),
      );
    } on NoticeException {
      // 읽음 기록 실패는 사용자에게 알리지 않습니다.
    }
  }
}
