import '../repositories/notice_repository.dart';
import 'usecase.dart';

/// MarkNoticeRead 전용 파라미터
final class MarkNoticeReadParams extends Params {
  const MarkNoticeReadParams({required this.meetingId, required this.noticeId});

  final int meetingId;
  final int noticeId;
}

/// 공지 읽음 처리 (3-6)
abstract class MarkNoticeRead extends Usecase<void, MarkNoticeReadParams> {}

final class MarkNoticeReadImpl implements MarkNoticeRead {
  MarkNoticeReadImpl({required NoticeRepository noticeRepository})
    : _noticeRepository = noticeRepository;

  final NoticeRepository _noticeRepository;

  @override
  Future<void> call(MarkNoticeReadParams params) {
    return _noticeRepository.markNoticeRead(
      meetingId: params.meetingId,
      noticeId: params.noticeId,
    );
  }
}
