import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/usecases/delete_schedule.dart';

import '../providers/schedule_providers.dart';
import 'schedule_delete_state.dart';
import 'schedule_delete_status.dart';

/// 일정 취소 ViewModel 입니다. [scheduleId] 일정을 취소하고 과정을 [ScheduleDeleteState] 로 알립니다.
class ScheduleDeleteViewModel extends Notifier<ScheduleDeleteState> {
  ScheduleDeleteViewModel({required this.meetingId, required this.scheduleId});

  final int meetingId;
  final int scheduleId;

  @override
  ScheduleDeleteState build() => const ScheduleDeleteState();

  Future<void> cancel() async {
    if (state.status == ScheduleDeleteStatus.submitting) return; // 중복 탭 방지
    state = const ScheduleDeleteState(status: ScheduleDeleteStatus.submitting);
    // 요청 중에 화면이 닫혀도 성공 후 캐시를 갱신할 수 있게, 끝날 때까지 유지합니다.
    final keepAliveLink = ref.keepAlive();

    ScheduleDeleteStatus result;
    try {
      await ref.read(deleteScheduleProvider)(
        DeleteScheduleParams(meetingId: meetingId, scheduleId: scheduleId),
      );
      result = ScheduleDeleteStatus.success;
    } catch (_) {
      result = ScheduleDeleteStatus.failure;
    }

    if (!ref.mounted) return; // 요청 중에 container 가 정리된 경우
    if (result == ScheduleDeleteStatus.success) {
      ref.invalidate(scheduleListProvider);
    }
    state = ScheduleDeleteState(status: result);
    keepAliveLink.close();
  }
}
