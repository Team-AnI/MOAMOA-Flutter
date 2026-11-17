import 'package:moamoa/core/usecases/usecase.dart';

import '../entities/vote_responses.dart';
import '../repositories/vote_repository.dart';

/// GetVoteResponses 전용 파라미터입니다.
final class GetVoteResponsesParams extends Params {
  const GetVoteResponsesParams({
    required this.meetingId,
    required this.scheduleId,
  });

  final int meetingId;
  final int scheduleId;

  @override
  List<Object?> get props => [meetingId, scheduleId];
}

/// "투표 참여 현황 조회"(5-4, 관리자)를 담당합니다.
/// 테스트에서 Fake 로 대체하기 위한 추상 클래스입니다.
abstract class GetVoteResponses
    extends Usecase<VoteResponses, GetVoteResponsesParams> {}

final class GetVoteResponsesImpl implements GetVoteResponses {
  GetVoteResponsesImpl({required VoteRepository voteRepository})
    : _voteRepository = voteRepository;

  final VoteRepository _voteRepository;

  @override
  Future<VoteResponses> call(GetVoteResponsesParams params) {
    return _voteRepository.getVoteResponses(
      meetingId: params.meetingId,
      scheduleId: params.scheduleId,
    );
  }
}
