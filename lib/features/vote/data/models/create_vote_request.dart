import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_vote_request.freezed.dart';
part 'create_vote_request.g.dart';

/// 투표 만들기(5-1) 요청. [toJson] 은 요청 본문(title, voteDeadlineAt, meetingTimes)이 됩니다.
/// 일시는 ISO-8601 문자열입니다.
@freezed
abstract class CreateVoteRequest with _$CreateVoteRequest {
  const factory CreateVoteRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    required String title,
    required String voteDeadlineAt,
    required List<String> meetingTimes,
  }) = _CreateVoteRequest;

  factory CreateVoteRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateVoteRequestFromJson(json);
}
