/// 모임 공지
///
/// 목록 조회(3-2)에서는 [content] 가 없고, 상세 조회(3-3)에서만 채워집니다.
/// [authorName], [isPinned], [isImportant], [isEdited] 는 API 명세에 아직 없어
/// 서버가 보내줄 때만 채워집니다. (지금은 Fake 데이터로 확인)
class Notice {
  const Notice({
    required this.id,
    required this.title,
    required this.createdAt,
    this.content,
    this.authorName,
    this.isPinned = false,
    this.isImportant = false,
    this.isEdited = false,
  });

  final int id;
  final String title;
  final String? content;
  final DateTime createdAt;

  /// 작성자 닉네임
  final String? authorName;

  /// 목록 맨 위 고정 여부
  final bool isPinned;

  /// 중요 공지 여부. 목록에 "중요" 뱃지가 붙습니다.
  // TODO: API 명세 확정 시 필드 이름 확인 (임시: isImportant)
  final bool isImportant;

  /// 작성 후 수정된 공지인지. 날짜 옆에 "수정됨"이 붙습니다.
  // TODO: API 명세 확정 시 필드 이름 확인 (임시: isEdited)
  final bool isEdited;
}
