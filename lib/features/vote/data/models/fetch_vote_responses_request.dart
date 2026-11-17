import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_vote_responses_request.freezed.dart';

/// 투표 참여 현황 조회(5-4) 요청
@freezed
abstract class FetchVoteResponsesRequest with _$FetchVoteResponsesRequest {
  const factory FetchVoteResponsesRequest({
    required int meetingId,
    required int scheduleId,
  }) = _FetchVoteResponsesRequest;
}
