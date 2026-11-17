import 'package:moamoa/core/utils/profile_name.dart';

import '../domain/entities/notice.dart';
import '../domain/entities/notice_read_member.dart';
import '../domain/entities/notice_reads.dart';

/// 상세 화면의 작성일. 연도까지 항상 표시합니다. (예: 2026년 9월 12일)
String formatNoticeDate(DateTime date) {
  return '${date.year}년 ${date.month}월 ${date.day}일';
}

/// 목록의 작성 시각. 오래될수록 거칠게 표시합니다.
///
/// "방금 전" → "3분 전" → "3시간 전" → "2일 전" → "1주 전" → "3개월 전" → "1년 전"
/// 한 달은 30일, 한 해는 365일로 계산합니다.
///
/// [now] 는 테스트에서 기준 시각을 고정할 때만 넘깁니다.
String formatNoticeRelative(DateTime createdAt, {DateTime? now}) {
  final diff = (now ?? DateTime.now()).difference(createdAt);
  if (diff.inMinutes < 1) return '방금 전';
  if (diff.inHours < 1) return '${diff.inMinutes}분 전';
  if (diff.inDays < 1) return '${diff.inHours}시간 전';
  if (diff.inDays < 7) return '${diff.inDays}일 전';
  if (diff.inDays < 30) return '${diff.inDays ~/ 7}주 전';
  if (diff.inDays < 365) return '${diff.inDays ~/ 30}개월 전';
  return '${diff.inDays ~/ 365}년 전';
}

/// 공지에 함께 보여주는 작성자 이름과 작성 시각
///
/// 작성자 이름은 공통 규칙대로 보여줍니다. 이름이 없으면 "이름 미설정",
/// 나간·탈퇴한 작성자는 서버가 보낸 "탈퇴한 사용자" 그대로입니다.
/// 작성자를 아직 받지 못한 공지는 작성 시각만 보여줍니다.
extension NoticeMetaX on Notice {
  /// 목록의 "김모아 · 1일 전"
  String get listMeta => _withAuthorName(formatNoticeRelative(createdAt));

  /// 상세의 "김모아 · 2026년 9월 12일"
  String get detailMeta => _withAuthorName(formatNoticeDate(createdAt));

  String _withAuthorName(String time) {
    final author = this.author;
    if (author == null) return time;
    return '${author.userName.profileDisplayName} · $time';
  }
}

/// 목록의 읽음 현황 표시 값 (3-2 readCount / totalCount)
extension NoticeReadCountX on Notice {
  /// "읽음 6/8". 읽은 수를 받지 못했으면 null 입니다.
  String? get readCountLabel {
    final readCount = this.readCount;
    final totalCount = this.totalCount;
    if (readCount == null || totalCount == null) return null;
    return '읽음 $readCount/$totalCount';
  }

  /// 모든 구성원이 읽었는지
  bool get isReadByAll => readCount != null && readCount == totalCount;
}

/// 상세의 "읽은 구성원" 표시 값 (3-7)
extension NoticeReadsDisplayX on NoticeReads {
  /// 프로필 동그라미로 보여줄 최대 인원. 넘는 인원은 "+N" 으로 보여줍니다.
  static const maxStackMembers = 6;

  /// 안 읽은 구성원 안내에 이름을 보여줄 최대 인원. 넘는 인원은 "외 N명" 으로 줄입니다.
  static const maxUnreadNames = 2;

  /// "6/8"
  String get countLabel => '$readCount/$totalCount';

  /// 프로필 동그라미로 보여줄 읽은 구성원 (읽은 순서대로)
  List<NoticeReadMember> get stackMembers =>
      readMembers.take(maxStackMembers).toList();

  /// 프로필 동그라미로 다 보여주지 못한 읽은 구성원 수
  int get hiddenReaderCount => readMembers.length - stackMembers.length;

  /// "+3". 다 보여줬으면 null 입니다.
  String? get hiddenReaderLabel =>
      hiddenReaderCount > 0 ? '+$hiddenReaderCount' : null;

  /// "박지훈, 최민아 님이 아직 안 읽었어요." · "박지훈, 최민아 님 외 3명이 아직 안 읽었어요."
  ///
  /// 이름은 공통 규칙대로 보여줍니다. 이름이 없으면 "이름 미설정" 입니다.
  String get unreadLabel {
    if (unreadMembers.isEmpty) return '모두 읽었어요.';
    final names = unreadMembers
        .take(maxUnreadNames)
        .map((member) => member.userName.profileDisplayName)
        .join(', ');
    final rest = unreadMembers.length - maxUnreadNames;
    if (rest <= 0) return '$names 님이 아직 안 읽었어요.';
    return '$names 님 외 $rest명이 아직 안 읽었어요.';
  }
}
