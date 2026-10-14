import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/notice_list_result.dart';
import '../repositories/notice_repository.dart';
import 'usecase.dart';

part 'get_notices.freezed.dart';

/// GetNotices 전용 파라미터
@freezed
abstract class GetNoticesParams extends Params with _$GetNoticesParams {
  const GetNoticesParams._();

  const factory GetNoticesParams({
    required int meetingId,

    /// 0부터 시작
    @Default(0) int page,
    @Default(20) int size,
  }) = _GetNoticesParams;
}

/// 공지 목록 조회 (3-2)
abstract class GetNotices extends Usecase<NoticeListResult, GetNoticesParams> {}

final class GetNoticesImpl implements GetNotices {
  GetNoticesImpl({required NoticeRepository noticeRepository})
    : _noticeRepository = noticeRepository;

  final NoticeRepository _noticeRepository;

  @override
  Future<NoticeListResult> call(GetNoticesParams params) {
    return _noticeRepository.getNotices(
      meetingId: params.meetingId,
      page: params.page,
      size: params.size,
    );
  }
}
