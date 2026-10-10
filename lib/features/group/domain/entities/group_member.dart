import 'package:freezed_annotation/freezed_annotation.dart';

import 'member_role.dart';

part 'group_member.freezed.dart';

/// 한 모임에 속한 사용자의 구성원 정보입니다.
@freezed
abstract class GroupMember with _$GroupMember {
  const factory GroupMember({
    required int groupId,

    /// 생성·가입·목록 응답에는 userId가 없으므로, 계정 조회 연동 전에는 null입니다.
    int? userId,
    required MemberRole role,
  }) = _GroupMember;
}
