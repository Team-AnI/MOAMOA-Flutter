import 'notice.dart';

/// 페이지 단위 공지 목록 조회 결과 (3-2)
class NoticeListResult {
  const NoticeListResult({
    required this.notices,
    required this.page,
    required this.size,
    required this.hasNext,
  });

  final List<Notice> notices;
  final int page;
  final int size;
  final bool hasNext;
}
