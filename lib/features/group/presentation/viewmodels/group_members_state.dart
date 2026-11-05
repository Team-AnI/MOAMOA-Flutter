import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/group_failure_reason.dart';
import '../../domain/entities/group_member_profile.dart';
import '../../domain/entities/member_role.dart';

part 'group_members_state.freezed.dart';

@freezed
abstract class GroupMembersState with _$GroupMembersState {
  const factory GroupMembersState({
    @Default([]) List<GroupMemberProfile> members,
    GroupFailureReason? failureReason,
  }) = _GroupMembersState;
}

extension GroupMembersStateX on GroupMembersState {
  String get countLabel => '총 ${members.length}명';
  bool get hasFailed => failureReason != null;
  bool get canRetry => failureReason == GroupFailureReason.unavailable;
  String get message => switch (failureReason) {
    GroupFailureReason.unauthorized => '로그인이 필요해요.',
    GroupFailureReason.forbidden => '이 모임의 구성원만 목록을 볼 수 있어요.',
    GroupFailureReason.notFound => '모임을 찾을 수 없어요.',
    GroupFailureReason.invalidResponse => '구성원 정보를 표시할 수 없어요.',
    GroupFailureReason.validation => '올바른 모임을 선택해주세요.',
    _ => '구성원 목록을 불러오지 못했어요.\n잠시 후 다시 시도해 주세요.',
  };
}

extension GroupMemberProfileDisplayX on GroupMemberProfile {
  String get displayName =>
      userName == null || userName!.trim().isEmpty ? '이름 미설정' : userName!;
  String get initial => userName == null || userName!.trim().isEmpty
      ? '?'
      : String.fromCharCode(userName!.trim().runes.first);
  String get roleLabel => role == MemberRole.admin ? '관리자' : '구성원';
}
