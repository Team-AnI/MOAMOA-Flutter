import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_members_request.freezed.dart';

/// 구성원 조회 경로에만 사용하는 모임 ID입니다. GET 본문은 보내지 않습니다.
@freezed
abstract class GroupMembersRequest with _$GroupMembersRequest {
  const factory GroupMembersRequest({required int meetingId}) =
      _GroupMembersRequest;
}
