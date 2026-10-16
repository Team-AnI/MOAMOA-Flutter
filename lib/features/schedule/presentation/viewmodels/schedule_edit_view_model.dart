import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_detail_request.dart';
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

    ScheduleEditStatus result;
    try {
      final original = await ref.read(
        scheduleDetailProvider(
          ScheduleDetailRequest(meetingId: meetingId, scheduleId: scheduleId),
        ).future,
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

    if (!ref.mounted) return; // 제출 중에 화면이 닫힌 경우
    if (result == ScheduleEditStatus.success) {
      ref.invalidate(scheduleDetailProvider);
      ref.invalidate(scheduleListProvider);
    }
    state = ScheduleEditState(status: result);
  }
}
