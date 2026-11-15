import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote_member_response.freezed.dart';

/// 구성원 한 명의 투표 참여 여부입니다.
///
/// [userName] 은 사용자 기능이 생기기 전까지 null 입니다.
/// [submittedAt] 은 마지막 제출 시각이고, 제출하지 않았으면 null 입니다.
@freezed
abstract class VoteMemberResponse with _$VoteMemberResponse {
  const factory VoteMemberResponse({
    required int memberId,
    String? userName,
    required bool responded,
    DateTime? submittedAt,
  }) = _VoteMemberResponse;
}
