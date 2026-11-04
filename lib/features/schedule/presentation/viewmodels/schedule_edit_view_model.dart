import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/usecases/update_schedule.dart';

import '../providers/schedule_providers.dart';
import '../schedule_id.dart';
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
        scheduleDetailProvider(
          ScheduleId(meetingId: meetingId, scheduleId: scheduleId),
        ).future,
      );
      final changes = _changes(
        original,
        title: title,
        description: description,
        startAt: startAt,
        endAt: endAt,
        location: location,
      );
      if (changes != null) await ref.read(updateScheduleProvider)(changes);
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

  /// [original] 과 비교해 바뀐 필드만 담은 수정 요청을 만듭니다. 바뀐 필드가 없으면 null 입니다.
  UpdateScheduleParams? _changes(
    Schedule original, {
    required String title,
    required String description,
    required DateTime startAt,
    DateTime? endAt,
    required String location,
  }) {
    final changes = UpdateScheduleParams(
      meetingId: meetingId,
      scheduleId: scheduleId,
      title: _changedText(title, original.title),
      description: _changedText(description, original.description),
      startAt: _changedTime(startAt, original.startAt),
      endAt: _changedTime(endAt, original.endAt),
      location: _changedText(location, original.location),
    );
    return changes.hasChanges ? changes : null;
  }

  /// 앞뒤 공백을 지운 값이 [original] 과 다를 때만 돌려줍니다.
  String? _changedText(String value, String original) {
    final trimmed = value.trim();
    return trimmed == original ? null : trimmed;
  }

  /// [value] 가 [original] 과 다른 순간일 때만 돌려줍니다.
  /// 서버 응답은 UTC, 입력 폼은 로컬 시각이라 `==` 대신 같은 순간인지로 비교합니다.
  /// 종료 일시를 비우는 수정은 아직 지원하지 않아서 [value] 가 null 이면 바꾸지 않습니다.
  DateTime? _changedTime(DateTime? value, DateTime? original) {
    if (value == null) return null;
    if (original != null && value.isAtSameMomentAs(original)) return null;
    return value;
  }
}
