import '../../domain/entities/notice.dart';

/// 공지 목록 화면 상태
class NoticeListState {
  const NoticeListState({
    required this.notices,
    required this.page,
    required this.hasNext,
    this.isLoadingMore = false,
  });

  /// 지금까지 불러온 공지 (최신순)
  final List<Notice> notices;

  /// 마지막으로 불러온 페이지 번호 (0부터 시작)
  final int page;
  final bool hasNext;

  /// 다음 페이지를 불러오는 중인지
  final bool isLoadingMore;

  bool get isEmpty => notices.isEmpty;

  NoticeListState copyWith({
    List<Notice>? notices,
    int? page,
    bool? hasNext,
    bool? isLoadingMore,
  }) {
    return NoticeListState(
      notices: notices ?? this.notices,
      page: page ?? this.page,
      hasNext: hasNext ?? this.hasNext,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
