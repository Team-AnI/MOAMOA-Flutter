import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_notices.dart';
import '../providers/notice_providers.dart';
import 'notice_list_state.dart';

/// 공지 목록 ViewModel (family 인자: meetingId)
class NoticeListViewModel extends AsyncNotifier<NoticeListState> {
  NoticeListViewModel(this._meetingId);

  final int _meetingId;

  /// 첫 페이지를 새로 불러올 때마다 1씩 늘어나는 번호입니다.
  /// 다음 페이지 응답이 늦게 도착했을 때, 그사이 새로고침이 있었는지 확인하는 데 씁니다.
  int _generation = 0;

  @override
  Future<NoticeListState> build() => _fetchFirstPage();

  /// 당겨서 새로고침. 새로 불러오는 동안 기존 목록을 그대로 보여줍니다.
  Future<void> refresh() async {
    final result = await AsyncValue.guard(_fetchFirstPage);
    if (!ref.mounted) return;
    state = result;
  }

  /// 다음 페이지를 불러와 목록 뒤에 붙입니다.
  ///
  /// 요청 중에 새로고침이 일어나면, 늦게 도착한 이 응답은 버립니다.
  /// 실패하면 목록은 그대로 두고 NoticeException 을 던집니다.
  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasNext || current.isLoadingMore) return;

    final generation = _generation;
    bool isStale() => !ref.mounted || generation != _generation;

    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      final result = await ref.read(getNoticesProvider)(
        GetNoticesParams(meetingId: _meetingId, page: current.page + 1),
      );
      if (isStale()) return;
      state = AsyncData(
        current.copyWith(
          notices: [...current.notices, ...result.notices],
          page: result.page,
          hasNext: result.hasNext,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      if (isStale()) return;
      state = AsyncData(current);
      rethrow;
    }
  }

  Future<NoticeListState> _fetchFirstPage() async {
    _generation++;
    final result = await ref.read(getNoticesProvider)(
      GetNoticesParams(meetingId: _meetingId),
    );
    return NoticeListState(
      notices: result.notices,
      page: result.page,
      hasNext: result.hasNext,
    );
  }
}
