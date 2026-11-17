import 'package:freezed_annotation/freezed_annotation.dart';

part 'submit_my_vote_request.freezed.dart';
part 'submit_my_vote_request.g.dart';

/// 내 투표 제출·수정(5-3) 요청. [toJson] 은 요청 본문(meetingTimes)이 됩니다.
/// [meetingTimes] 가 비어 있으면 가능한 시간이 없다는 뜻입니다.
@freezed
abstract class SubmitMyVoteRequest with _$SubmitMyVoteRequest {
  const factory SubmitMyVoteRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    @JsonKey(includeToJson: false) required int scheduleId,
    required List<String> meetingTimes,
  }) = _SubmitMyVoteRequest;

  factory SubmitMyVoteRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitMyVoteRequestFromJson(json);
}
