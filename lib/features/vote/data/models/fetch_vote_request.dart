import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_vote_request.freezed.dart';

/// 투표 조회(5-2) 요청
@freezed
abstract class FetchVoteRequest with _$FetchVoteRequest {
  const factory FetchVoteRequest({
    required int meetingId,
    required int scheduleId,
  }) = _FetchVoteRequest;
}
