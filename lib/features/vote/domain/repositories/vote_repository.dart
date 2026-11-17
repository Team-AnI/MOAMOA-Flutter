import '../entities/vote.dart';
import '../entities/vote_responses.dart';

/// 투표 Repository
///
/// 실패하면 공통 `ApiException` 을 던집니다.
abstract interface class VoteRepository {
  /// 5-1 투표 만들기. 투표로 만든 일정의 id 를 돌려줍니다.
  Future<int> createVote({
    required int meetingId,
    required String title,
    required DateTime voteDeadlineAt,
    required List<DateTime> meetingTimes,
  });

  /// 5-2 투표 조회
  Future<Vote> getVote({required int meetingId, required int scheduleId});

  /// 5-3 내 투표 제출·수정. [meetingTimes] 가 비어 있으면 가능한 시간이 없다는 뜻입니다.
  Future<void> submitMyVote({
    required int meetingId,
    required int scheduleId,
    required List<DateTime> meetingTimes,
  });

  /// 5-4 투표 참여 현황 조회 (관리자)
  Future<VoteResponses> getVoteResponses({
    required int meetingId,
    required int scheduleId,
  });

  /// 5-5 일정 확정 (관리자)
  Future<void> confirmSchedule({
    required int meetingId,
    required int scheduleId,
    required DateTime meetingTime,
  });
}
