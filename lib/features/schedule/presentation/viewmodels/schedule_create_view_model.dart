import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/usecases/create_schedule.dart';

import '../providers/schedule_providers.dart';
import 'schedule_create_state.dart';
import 'schedule_create_status.dart';

/// 일정 만들기 ViewModel 입니다. [meetingId] 모임에 일정을 만들고 제출 과정을 [ScheduleCreateState] 로 알립니다.
class ScheduleCreateViewModel extends Notifier<ScheduleCreateState> {
  ScheduleCreateViewModel(this.meetingId);

  final int meetingId;

  @override
  ScheduleCreateState build() => const ScheduleCreateState();

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
      ref.invalidate(scheduleListProvider);
    }
    state = result;
  }
}
