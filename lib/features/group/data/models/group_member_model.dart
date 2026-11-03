import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/group_member_profile.dart';
import '../../domain/entities/group_profile_color.dart';
import '../../domain/entities/member_role.dart';

part 'group_member_model.freezed.dart';
part 'group_member_model.g.dart';

@Freezed(toJson: false)
abstract class GroupMemberModel with _$GroupMemberModel {
  const factory GroupMemberModel({
    @JsonKey(fromJson: GroupMemberModel._id) required int memberId,
    String? userName,
    @JsonKey(fromJson: GroupMemberModel._role) required MemberRole role,
    @JsonKey(fromJson: GroupMemberModel._color)
    @Default(GroupProfileColor.lightBlue)
    GroupProfileColor profileColor,
  }) = _GroupMemberModel;

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberModelFromJson(json);

  static int _id(Object? value) {
    if (value is! int || value <= 0) {
      throw const FormatException('잘못된 구성원 ID');
    }
    return value;
  }

  static MemberRole _role(Object? value) => switch (value) {
    'ADMIN' => MemberRole.admin,
    'MEMBER' => MemberRole.member,
    _ => throw const FormatException('알 수 없는 구성원 역할'),
  };

  static GroupProfileColor _color(Object? value) => switch (value) {
    null || 'LIGHT_BLUE' => GroupProfileColor.lightBlue,
    'GRAY' => GroupProfileColor.gray,
    'BLUE' => GroupProfileColor.blue,
    'DARK' => GroupProfileColor.dark,
    _ => throw const FormatException('알 수 없는 프로필 색'),
  };
}

extension GroupMemberModelX on GroupMemberModel {
  GroupMemberProfile toEntity() => GroupMemberProfile(
    memberId: memberId,
    userName: userName,
    role: role,
    profileColor: profileColor,
  );
}
