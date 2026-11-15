import 'package:moamoa/core/usecases/usecase.dart';

import '../repositories/vote_repository.dart';

/// ConfirmSchedule 전용 파라미터입니다.
final class ConfirmScheduleParams extends Params {
  const ConfirmScheduleParams({
    required this.meetingId,
    required this.scheduleId,
    required this.meetingTime,
  });

  final int meetingId;
  final int scheduleId;
  final DateTime meetingTime;

  @override
  List<Object?> get props => [meetingId, scheduleId, meetingTime];
}

/// "일정 확정"(5-5, 관리자)을 담당합니다. 확정한 후보 시간이 일정의 시작 일시가 됩니다.
/// 테스트에서 Fake 로 대체하기 위한 추상 클래스입니다.
abstract class ConfirmSchedule extends Usecase<void, ConfirmScheduleParams> {}

final class ConfirmScheduleImpl implements ConfirmSchedule {
  ConfirmScheduleImpl({required VoteRepository voteRepository})
    : _voteRepository = voteRepository;

  final VoteRepository _voteRepository;

  @override
  Future<void> call(ConfirmScheduleParams params) {
    return _voteRepository.confirmSchedule(
      meetingId: params.meetingId,
      scheduleId: params.scheduleId,
      meetingTime: params.meetingTime,
    );
  }
}
