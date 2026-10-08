/// 모임 공지
///
/// 목록 조회(3-2)에서는 [content] 가 없고, 상세 조회(3-3)에서만 채워집니다.
class Notice {
  const Notice({
    required this.id,
    required this.title,
    required this.createdAt,
    this.content,
  });

  final int id;
  final String title;
  final String? content;
  final DateTime createdAt;
}
