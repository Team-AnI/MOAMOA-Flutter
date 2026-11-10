import 'package:moamoa/core/utils/profile_name.dart';

import '../domain/entities/notice.dart';

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
