import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_list_request.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';

/// 기간 내 일정 목록(시작 일시 오름차순)
class ScheduleListViewModel extends AsyncNotifier<List<Schedule>> {
  ScheduleListViewModel(this.request);

  final ScheduleListRequest request;

  @override
  Future<List<Schedule>> build() => _fetch();

  Future<void> refresh() async {
    // 이미 불러오는 중이면 무시한다. (늦게 끝난 이전 응답이 최신 목록을 덮어쓰는 것을 방지)
    if (state.isLoading) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }

  Future<List<Schedule>> _fetch() {
    return ref.read(scheduleRepositoryProvider).getSchedules(request);
  }
}
