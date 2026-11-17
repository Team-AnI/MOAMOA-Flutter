import 'package:freezed_annotation/freezed_annotation.dart';

import 'notice_read_member.dart';

part 'notice_reads.freezed.dart';

/// 공지 읽음 현황 (3-7)
///
/// 현재 모임 구성원 기준입니다. [totalCount] 는 [readCount] 와 안 읽은 구성원 수의 합입니다.
@freezed
abstract class NoticeReads with _$NoticeReads {
  const factory NoticeReads({
    required int readCount,
    required int totalCount,

    /// 읽은 시각 순서
    required List<NoticeReadMember> readMembers,

    /// memberId 오름차순 (모임 가입 순)
    required List<NoticeReadMember> unreadMembers,
  }) = _NoticeReads;
}
