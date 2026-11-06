import 'package:moamoa/core/usecases/usecase.dart';

import '../repositories/vote_repository.dart';

/// CreateVote 전용 파라미터입니다.
final class CreateVoteParams extends Params {
  const CreateVoteParams({
    required this.meetingId,
    required this.title,
    required this.voteDeadlineAt,
    required this.meetingTimes,
  });

  final int meetingId;
  final String title;
  final DateTime voteDeadlineAt;
  final List<DateTime> meetingTimes;

  @override
  List<Object?> get props => [meetingId, title, voteDeadlineAt, meetingTimes];
}

/// "투표 만들기"(5-1)를 담당합니다. 투표로 만든 일정의 id 를 돌려줍니다.
/// 테스트에서 Fake 로 대체하기 위한 추상 클래스입니다.
abstract class CreateVote extends Usecase<int, CreateVoteParams> {}

final class CreateVoteImpl implements CreateVote {
  CreateVoteImpl({required VoteRepository voteRepository})
    : _voteRepository = voteRepository;

  final VoteRepository _voteRepository;

  @override
  Future<int> call(CreateVoteParams params) {
    return _voteRepository.createVote(
      meetingId: params.meetingId,
      title: params.title.trim(),
      voteDeadlineAt: params.voteDeadlineAt,
      meetingTimes: params.meetingTimes,
    );
  }
}
