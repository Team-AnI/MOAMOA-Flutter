import 'package:moamoa/features/schedule/domain/usecases/create_schedule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/schedule_providers.dart';
import 'schedule_create_state.dart';
import 'schedule_create_status.dart';
import 'schedule_list_view_model.dart';

part 'schedule_create_view_model.g.dart';

/// 일정 만들기 ViewModel 입니다. [meetingId] 모임에 일정을 만들고 제출 과정을 [ScheduleCreateState] 로 알립니다.
///
/// autoDispose: 화면을 닫으면 이전 제출 결과(성공 id, 오류)가 남지 않게 초기화합니다.
@riverpod
class ScheduleCreateViewModel extends _$ScheduleCreateViewModel {
  @override
  ScheduleCreateState build(int meetingId) => const ScheduleCreateState();

  Future<void> submit({
    required String title,
    String description = '',
    required DateTime startAt,
    DateTime? endAt,
    String location = '',
  }) async {
    if (state.status == ScheduleCreateStatus.submitting) return; // 중복 탭 방지
    state = const ScheduleCreateState(status: ScheduleCreateStatus.submitting);

    ScheduleCreateState result;
    try {
      final created = await ref.read(createScheduleProvider)(
        CreateScheduleParams(
          meetingId: meetingId,
          title: title,
          description: description,
          startAt: startAt,
          endAt: endAt,
          location: location,
        ),
      );
      result = ScheduleCreateState(
        status: ScheduleCreateStatus.success,
        created: created,
      );
    } catch (_) {
      result = const ScheduleCreateState(status: ScheduleCreateStatus.failure);
    }

    if (!ref.mounted) return; // 제출 중에 화면이 닫힌 경우
    if (result.status == ScheduleCreateStatus.success) {
      ref.invalidate(scheduleListViewModelProvider);
    }
    state = result;
  }
}
