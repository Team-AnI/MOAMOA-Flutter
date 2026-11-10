import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/usecases/update_schedule.dart';

import '../providers/schedule_providers.dart';
import '../schedule_id.dart';
import 'schedule_edit_state.dart';
import 'schedule_edit_status.dart';

/// 일정 수정 ViewModel 입니다. [id] 일정의 바뀐 값을 속성마다 받아 두었다가 [submit] 으로 저장하고,
/// 제출 과정을 [ScheduleEditState] 로 알립니다.
class ScheduleEditViewModel extends Notifier<ScheduleEditState> {
  ScheduleEditViewModel({required this.id});

  final ScheduleId id;

  @override
  ScheduleEditState build() => const ScheduleEditState();

  /// 바뀐 이름. 원래 이름과 같으면 null 입니다.
  void changeTitle(String? title) => state = state.copyWith(title: title);

  /// 바뀐 설명. 원래 설명과 같으면 null 입니다.
  void changeDescription(String? description) =>
      state = state.copyWith(description: description);

  /// 바뀐 시작 일시. 원래 시작 일시와 같으면 null 입니다.
  void changeStartAt(DateTime? startAt) =>
      state = state.copyWith(startAt: startAt);

  /// 바뀐 종료 일시. 원래 종료 일시와 같으면 null 입니다.
  void changeEndAt(DateTime? endAt) => state = state.copyWith(endAt: endAt);

  /// 바뀐 장소. 원래 장소와 같으면 null 입니다.
  void changeLocation(String? location) =>
      state = state.copyWith(location: location);

  /// 받아 둔 바뀐 값만 저장합니다. null 인 값은 바꾸지 않습니다.
  Future<void> submit() async {
    if (state.status == ScheduleEditStatus.submitting) return; // 중복 탭 방지
    state = state.copyWith(status: ScheduleEditStatus.submitting);
    // 요청 중에 화면이 닫혀도 성공 후 캐시를 갱신할 수 있게, 끝날 때까지 유지합니다.
    final keepAliveLink = ref.keepAlive();

    ScheduleEditStatus result;
    try {
      await ref.read(updateScheduleProvider)(
        UpdateScheduleParams(
          meetingId: id.meetingId,
          scheduleId: id.scheduleId,
          title: state.title,
          description: state.description,
          startAt: state.startAt,
          endAt: state.endAt,
          location: state.location,
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
    state = state.copyWith(status: result);
    keepAliveLink.close();
  }
}
