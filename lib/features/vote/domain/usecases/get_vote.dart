import 'package:moamoa/core/usecases/usecase.dart';

import '../entities/vote.dart';
import '../repositories/vote_repository.dart';

/// GetVote 전용 파라미터입니다.
final class GetVoteParams extends Params {
  const GetVoteParams({required this.meetingId, required this.scheduleId});

  final int meetingId;
  final int scheduleId;

  @override
  List<Object?> get props => [meetingId, scheduleId];
}

/// "투표 조회"(5-2)를 담당합니다.
/// 테스트에서 Fake 로 대체하기 위한 추상 클래스입니다.
abstract class GetVote extends Usecase<Vote, GetVoteParams> {}

final class GetVoteImpl implements GetVote {
  GetVoteImpl({required VoteRepository voteRepository})
    : _voteRepository = voteRepository;

  final VoteRepository _voteRepository;

  @override
  Future<Vote> call(GetVoteParams params) {
    return _voteRepository.getVote(
      meetingId: params.meetingId,
      scheduleId: params.scheduleId,
    );
  }
}
