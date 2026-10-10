import '../entities/notice_list_result.dart';
import '../repositories/notice_repository.dart';
import 'usecase.dart';

/// GetNotices 전용 파라미터
final class GetNoticesParams extends Params {
  const GetNoticesParams({
    required this.meetingId,
    this.page = 0,
    this.size = 20,
  });

  final int meetingId;

  /// 0부터 시작
  final int page;
  final int size;
}

/// 공지 목록 조회 (3-2)
abstract class GetNotices extends Usecase<NoticeListResult, GetNoticesParams> {}

final class GetNoticesImpl implements GetNotices {
  GetNoticesImpl({required NoticeRepository repository})
    : _repository = repository;

  final NoticeRepository _repository;

  @override
  Future<NoticeListResult> call(GetNoticesParams params) {
    return _repository.getNotices(
      meetingId: params.meetingId,
      page: params.page,
      size: params.size,
    );
  }
}
