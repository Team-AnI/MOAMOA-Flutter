import '../repositories/notice_repository.dart';
import 'usecase.dart';

/// SetNoticePinned 전용 파라미터
final class SetNoticePinnedParams extends Params {
  const SetNoticePinnedParams({
    required this.meetingId,
    required this.noticeId,
    required this.pinned,
  });

  final int meetingId;
  final int noticeId;

  /// true 면 고정, false 면 고정 해제
  final bool pinned;
}

/// 공지 고정 / 고정 해제
abstract class SetNoticePinned extends Usecase<void, SetNoticePinnedParams> {}

final class SetNoticePinnedImpl implements SetNoticePinned {
  SetNoticePinnedImpl({required NoticeRepository repository})
    : _repository = repository;

  final NoticeRepository _repository;

  @override
  Future<void> call(SetNoticePinnedParams params) {
    return _repository.setPinned(
      meetingId: params.meetingId,
      noticeId: params.noticeId,
      pinned: params.pinned,
    );
  }
}
