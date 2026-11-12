import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/group_member_profile.dart';
import '../../domain/entities/group_profile_color.dart';
import '../../domain/entities/member_role.dart';

part 'group_member_model.freezed.dart';
part 'group_member_model.g.dart';

@Freezed(toJson: false)
abstract class GroupMemberModel with _$GroupMemberModel {
  const factory GroupMemberModel({
    required num memberId,
    String? userName,
    required String role,
    Object? profileColor,
  }) = _GroupMemberModel;

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberModelFromJson(json);
}

extension GroupMemberModelX on GroupMemberModel {
  GroupMemberProfile toEntity() => GroupMemberProfile(
    memberId: memberId as int,
    userName: userName,
    role: MemberRole.fromServer(role),
    profileColor: GroupProfileColor.fromServer(profileColor),
  );
}
