import '../repositories/notice_repository.dart';
import 'usecase.dart';

/// DeleteNotice 전용 파라미터
final class DeleteNoticeParams extends Params {
  const DeleteNoticeParams({required this.meetingId, required this.noticeId});

  final int meetingId;
  final int noticeId;
}

/// 공지 삭제 (3-5)
abstract class DeleteNotice extends Usecase<void, DeleteNoticeParams> {}

final class DeleteNoticeImpl implements DeleteNotice {
  DeleteNoticeImpl({required this._repository});

  final NoticeRepository _repository;

  @override
  Future<void> call(DeleteNoticeParams params) {
    return _repository.deleteNotice(
      meetingId: params.meetingId,
      noticeId: params.noticeId,
    );
  }
}
