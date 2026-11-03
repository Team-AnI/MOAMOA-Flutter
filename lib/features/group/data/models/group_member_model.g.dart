// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupMemberModel _$GroupMemberModelFromJson(Map<String, dynamic> json) =>
    _GroupMemberModel(
      memberId: GroupMemberModel._id(json['memberId']),
      userName: json['userName'] as String?,
      role: GroupMemberModel._role(json['role']),
      profileColor: json['profileColor'] == null
          ? GroupProfileColor.lightBlue
          : GroupMemberModel._color(json['profileColor']),
    );
