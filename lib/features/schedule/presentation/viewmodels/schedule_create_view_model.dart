import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/usecases/create_schedule.dart';

import '../providers/schedule_providers.dart';

/// 일정 생성 ViewModel. 상태는 제출 결과를 나타냅니다.
/// - data(null): 아직 제출 전 / loading: 제출 중 / data(id): 생성 성공
/// - error: 실패. 입력 문제면 ScheduleValidationException
class ScheduleCreateViewModel extends AsyncNotifier<int?> {
  ScheduleCreateViewModel(this.meetingId);

  final int meetingId;

  @override
  int? build() => null;

  Future<void> submit({
    required String title,
    String description = '',
    DateTime? startAt,
    DateTime? endAt,
    String location = '',
  }) async {
    if (state.isLoading) return; // 중복 탭 방지
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(createScheduleProvider)(
        CreateScheduleParams(
          meetingId: meetingId,
          title: title,
          description: description,
          startAt: startAt,
          endAt: endAt,
          location: location,
        ),
      ),
    );
    if (!ref.mounted) return; // 제출 중에 화면이 닫힌 경우
    if (!result.hasError) ref.invalidate(scheduleListProvider);
    state = result;
  }
}
