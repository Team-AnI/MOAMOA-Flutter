import 'notice_account.dart';

/// 모임 공지
///
/// 목록 조회(3-2)에서는 [content] 가 없고, 상세 조회(3-3)에서만 채워집니다.
/// [authorName], [isPinned], [account] 는 API 명세에 아직 없어
/// 서버가 보내줄 때만 채워집니다. (지금은 Fake 데이터로 확인)
class Notice {
  const Notice({
    required this.id,
    required this.title,
    required this.createdAt,
    this.content,
    this.authorName,
    this.isPinned = false,
    this.account,
  });

  final int id;
  final String title;
  final String? content;
  final DateTime createdAt;

  /// 작성자 닉네임
  final String? authorName;

  /// 목록 맨 위 고정 여부
  final bool isPinned;

  /// 함께 보여줄 관리자 계좌
  final NoticeAccount? account;
}
