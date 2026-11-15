import 'package:moamoa/core/usecases/usecase.dart';

import '../repositories/vote_repository.dart';

/// SubmitMyVote 전용 파라미터입니다.
/// [meetingTimes] 가 비어 있으면 가능한 시간이 없다는 뜻입니다.
final class SubmitMyVoteParams extends Params {
  const SubmitMyVoteParams({
    required this.meetingId,
    required this.scheduleId,
    required this.meetingTimes,
  });

  final int meetingId;
  final int scheduleId;
  final List<DateTime> meetingTimes;

  @override
  List<Object?> get props => [meetingId, scheduleId, meetingTimes];
}

/// "내 투표 제출·수정"(5-3)을 담당합니다. 다시 제출하면 이전 선택을 모두 바꿉니다.
/// 테스트에서 Fake 로 대체하기 위한 추상 클래스입니다.
abstract class SubmitMyVote extends Usecase<void, SubmitMyVoteParams> {}

final class SubmitMyVoteImpl implements SubmitMyVote {
  SubmitMyVoteImpl({required VoteRepository voteRepository})
    : _voteRepository = voteRepository;

  final VoteRepository _voteRepository;

  @override
  Future<void> call(SubmitMyVoteParams params) {
    return _voteRepository.submitMyVote(
      meetingId: params.meetingId,
      scheduleId: params.scheduleId,
      meetingTimes: params.meetingTimes,
    );
  }
}
