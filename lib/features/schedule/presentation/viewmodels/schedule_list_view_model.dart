import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';

/// 일정 목록 조회 조건. 같은 값이면 같은 Provider 로 취급되므로
/// 날짜는 시각을 뺀 값(예: DateTime(2026, 10, 1))으로 넘기는 것이 좋습니다.
typedef ScheduleListArgs = ({
  int meetingId,
  DateTime startDate,
  DateTime endDate,
});

/// 기간 내 일정 목록(시작 일시 오름차순)
class ScheduleListViewModel extends AsyncNotifier<List<Schedule>> {
  ScheduleListViewModel(this.args);

  final ScheduleListArgs args;

  @override
  Future<List<Schedule>> build() => _fetch();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }

  Future<List<Schedule>> _fetch() {
    return ref
        .read(scheduleRepositoryProvider)
        .getSchedules(
          meetingId: args.meetingId,
          startDate: args.startDate,
          endDate: args.endDate,
        );
  }
}
