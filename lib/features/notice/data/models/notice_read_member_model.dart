import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/core/constants/profile_color.dart';

import '../../domain/entities/notice_read_member.dart';

part 'notice_read_member_model.freezed.dart';
part 'notice_read_member_model.g.dart';

/// 공지 읽음 현황(3-7)의 readMembers · unreadMembers 항목
@freezed
abstract class NoticeReadMemberModel with _$NoticeReadMemberModel {
  const factory NoticeReadMemberModel({
    required int memberId,
    String? userName,

    /// LIGHT_BLUE · GRAY · BLUE · DARK
    String? profileColor,

    /// ISO-8601 (KST). unreadMembers 항목에는 없습니다.
    String? readAt,
  }) = _NoticeReadMemberModel;

  factory NoticeReadMemberModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeReadMemberModelFromJson(json);
}

/// 응답 모델을 도메인 Entity 로 바꿉니다.
extension NoticeReadMemberModelX on NoticeReadMemberModel {
  NoticeReadMember toEntity() {
    final readAt = this.readAt;
    return NoticeReadMember(
      memberId: memberId,
      userName: userName,
      profileColor: ProfileColor.fromServer(profileColor),
      readAt: readAt == null ? null : DateTime.parse(readAt).toLocal(),
    );
  }
}
