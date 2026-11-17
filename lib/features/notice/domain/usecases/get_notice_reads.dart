import '../entities/notice_reads.dart';
import '../repositories/notice_repository.dart';
import 'usecase.dart';

/// GetNoticeReads 전용 파라미터
final class GetNoticeReadsParams extends Params {
  const GetNoticeReadsParams({required this.meetingId, required this.noticeId});

  final int meetingId;
  final int noticeId;
}

/// 공지 읽음 현황 조회 (3-7)
abstract class GetNoticeReads
    extends Usecase<NoticeReads, GetNoticeReadsParams> {}

final class GetNoticeReadsImpl implements GetNoticeReads {
  GetNoticeReadsImpl({required NoticeRepository noticeRepository})
    : _noticeRepository = noticeRepository;

  final NoticeRepository _noticeRepository;

  @override
  Future<NoticeReads> call(GetNoticeReadsParams params) {
    return _noticeRepository.getNoticeReadsByNoticeId(
      meetingId: params.meetingId,
      noticeId: params.noticeId,
    );
  }
}
