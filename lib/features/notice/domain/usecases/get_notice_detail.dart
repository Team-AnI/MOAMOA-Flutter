import '../entities/notice.dart';
import '../repositories/notice_repository.dart';
import 'usecase.dart';

/// GetNoticeDetail 전용 파라미터
final class GetNoticeDetailParams extends Params {
  const GetNoticeDetailParams({
    required this.meetingId,
    required this.noticeId,
  });

  final int meetingId;
  final int noticeId;
}

/// 공지 상세 조회 (3-3)
abstract class GetNoticeDetail extends Usecase<Notice, GetNoticeDetailParams> {}

final class GetNoticeDetailImpl implements GetNoticeDetail {
  GetNoticeDetailImpl({required NoticeRepository repository})
    : _repository = repository;

  final NoticeRepository _repository;

  @override
  Future<Notice> call(GetNoticeDetailParams params) {
    return _repository.getNoticeDetail(
      meetingId: params.meetingId,
      noticeId: params.noticeId,
    );
  }
}
