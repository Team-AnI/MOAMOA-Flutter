import 'package:freezed_annotation/freezed_annotation.dart';

import '../repositories/notice_repository.dart';
import 'usecase.dart';

part 'delete_notice.freezed.dart';

/// DeleteNotice 전용 파라미터
@freezed
abstract class DeleteNoticeParams extends Params with _$DeleteNoticeParams {
  const DeleteNoticeParams._();

  const factory DeleteNoticeParams({
    required int meetingId,
    required int noticeId,
  }) = _DeleteNoticeParams;
}

/// 공지 삭제 (3-5)
abstract class DeleteNotice extends Usecase<void, DeleteNoticeParams> {}

final class DeleteNoticeImpl implements DeleteNotice {
  DeleteNoticeImpl({required NoticeRepository noticeRepository})
    : _noticeRepository = noticeRepository;

  final NoticeRepository _noticeRepository;

  @override
  Future<void> call(DeleteNoticeParams params) {
    return _noticeRepository.deleteNotice(
      meetingId: params.meetingId,
      noticeId: params.noticeId,
    );
  }
}
