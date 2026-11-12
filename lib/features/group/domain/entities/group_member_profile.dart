import 'package:freezed_annotation/freezed_annotation.dart';

import 'group_profile_color.dart';
import 'member_role.dart';

part 'group_member_profile.freezed.dart';

/// 구성원 목록의 memberId입니다. 계정 userId와 구분합니다.
@freezed
abstract class GroupMemberProfile with _$GroupMemberProfile {
  const factory GroupMemberProfile({
    required int memberId,
    String? userName,
    required MemberRole role,
    @Default(GroupProfileColor.lightBlue) GroupProfileColor profileColor,
  }) = _GroupMemberProfile;
}
