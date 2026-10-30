import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/usecases/update_schedule.dart';

import '../providers/schedule_providers.dart';
import 'schedule_edit_state.dart';
import 'schedule_edit_status.dart';

/// 일정 수정 ViewModel 입니다. [scheduleId] 일정을 수정하고 제출 과정을 [ScheduleEditState] 로 알립니다.
class ScheduleEditViewModel extends Notifier<ScheduleEditState> {
  ScheduleEditViewModel({required this.meetingId, required this.scheduleId});

  final int meetingId;
  final int scheduleId;

  @override
  ScheduleEditState build() => const ScheduleEditState();

  Future<void> submit({
    required String title,
    String description = '',
    required DateTime startAt,
    DateTime? endAt,
    String location = '',
  }) async {
    if (state.status == ScheduleEditStatus.submitting) return; // 중복 탭 방지
    state = const ScheduleEditState(status: ScheduleEditStatus.submitting);
    // 요청 중에 화면이 닫혀도 성공 후 캐시를 갱신할 수 있게, 끝날 때까지 유지합니다.
    final keepAliveLink = ref.keepAlive();

    ScheduleEditStatus result;
    try {
      final original = await ref.read(
        scheduleDetailProvider((
          meetingId: meetingId,
          scheduleId: scheduleId,
        )).future,
      );
      await ref.read(updateScheduleProvider)(
        UpdateScheduleParams(
          meetingId: meetingId,
          original: original,
          title: title,
          description: description,
          startAt: startAt,
          endAt: endAt,
          location: location,
        ),
      );
      result = ScheduleEditStatus.success;
    } catch (_) {
      result = ScheduleEditStatus.failure;
    }

    if (!ref.mounted) return; // 요청 중에 container 가 정리된 경우
    if (result == ScheduleEditStatus.success) {
      ref.invalidate(scheduleDetailProvider);
      ref.invalidate(scheduleListProvider);
    }
    state = ScheduleEditState(status: result);
    keepAliveLink.close();
  }
}
