import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote_id.freezed.dart';

/// 투표 조회·응답 현황·확정 Provider 가 키로 쓰는 투표 식별자입니다.
/// 투표는 일정 하나에 붙어 있어서 모임 id 와 일정 id 로 찾습니다.
@freezed
abstract class VoteId with _$VoteId {
  const factory VoteId({required int meetingId, required int scheduleId}) =
      _VoteId;
}
