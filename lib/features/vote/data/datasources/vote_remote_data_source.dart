import '../models/confirm_schedule_request.dart';
import '../models/create_vote_request.dart';
import '../models/fetch_vote_request.dart';
import '../models/fetch_vote_responses_request.dart';
import '../models/submit_my_vote_request.dart';
import '../models/vote_model.dart';
import '../models/vote_responses_model.dart';

/// 투표 API 호출
abstract interface class VoteRemoteDataSource {
  /// POST /v1/meetings/{meetingId}/schedule-votes. 투표로 만든 일정의 id 를 반환합니다.
  Future<int> createVote(CreateVoteRequest request);

  /// GET /v1/meetings/{meetingId}/schedules/{scheduleId}/candidates
  Future<VoteModel> fetchVote(FetchVoteRequest request);

  /// PUT /v1/meetings/{meetingId}/schedules/{scheduleId}/votes/me
  Future<void> submitMyVote(SubmitMyVoteRequest request);

  /// GET /v1/meetings/{meetingId}/schedules/{scheduleId}/vote-responses
  Future<VoteResponsesModel> fetchVoteResponses(
    FetchVoteResponsesRequest request,
  );

  /// POST /v1/meetings/{meetingId}/schedules/{scheduleId}/confirmation
  Future<void> confirmSchedule(ConfirmScheduleRequest request);
}
