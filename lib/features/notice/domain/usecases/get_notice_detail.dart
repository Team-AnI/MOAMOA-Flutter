import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/notice.dart';
import '../repositories/notice_repository.dart';
import 'usecase.dart';

part 'get_notice_detail.freezed.dart';

/// GetNoticeDetail 전용 파라미터
@freezed
abstract class GetNoticeDetailParams extends Params
    with _$GetNoticeDetailParams {
  const GetNoticeDetailParams._();

  const factory GetNoticeDetailParams({
    required int meetingId,
    required int noticeId,
  }) = _GetNoticeDetailParams;
}

/// 공지 상세 조회 (3-3)
abstract class GetNoticeDetail extends Usecase<Notice, GetNoticeDetailParams> {}

final class GetNoticeDetailImpl implements GetNoticeDetail {
  GetNoticeDetailImpl({required NoticeRepository noticeRepository})
    : _noticeRepository = noticeRepository;

  final NoticeRepository _noticeRepository;

  @override
  Future<Notice> call(GetNoticeDetailParams params) {
    return _noticeRepository.getNoticeDetail(
      meetingId: params.meetingId,
      noticeId: params.noticeId,
    );
  }
}
