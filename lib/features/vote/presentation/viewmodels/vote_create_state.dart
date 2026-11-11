import 'package:freezed_annotation/freezed_annotation.dart';

import '../vote_format.dart';
import 'vote_create_status.dart';
import 'vote_time_range.dart';

part 'vote_create_state.freezed.dart';

/// 투표 만들기 화면의 입력값과 제출 상태입니다.
@freezed
abstract class VoteCreateState with _$VoteCreateState {
  const factory VoteCreateState({
    @Default('') String title,

    /// 후보 날짜(시각 없음). 오름차순입니다.
    @Default(<DateTime>[]) List<DateTime> dates,
    @Default(VoteTimeRange()) VoteTimeRange timeRange,
    DateTime? voteDeadlineAt,

    /// 마지막으로 확인했을 때(고를 때·제출할 때) [voteDeadlineAt] 이 지금 이전이었으면 true 입니다.
    @Default(false) bool deadlinePassed,

    /// 빈 항목이 있는데 시작 버튼을 누르면 true 가 되어 항목마다 오류 문구를 보여줍니다.
    @Default(false) bool showErrors,
    @Default(VoteCreateStatus.initial) VoteCreateStatus status,

    /// [status] 가 success 일 때만 값이 있습니다. 투표로 만든 일정의 id 입니다.
    int? createdScheduleId,

    /// [status] 가 failure 일 때 보여줄 문구입니다.
    String? errorMessage,
  }) = _VoteCreateState;
}

extension VoteCreateStateX on VoteCreateState {
  bool get _titleMissing => title.trim().isEmpty;

  /// 아직 채우지 않은 항목(이름, 후보 날짜, 투표 마감) 수
  int get missingCount => [
    _titleMissing,
    dates.isEmpty,
    voteDeadlineAt == null,
  ].where((missing) => missing).length;

  bool get canSubmit =>
      missingCount == 0 &&
      !deadlinePassed &&
      timeRange.isValid &&
      status != VoteCreateStatus.submitting;

  /// 후보 날짜마다 후보 시각을 붙인 후보 시간 목록 (날짜 순, 같은 날은 시각 순)
  /// 자정에 시간을 더하지 않고 시·분으로 만들어 서머타임이 바뀌는 날에도 시각이 밀리지 않습니다.
  List<DateTime> get meetingTimes => [
    for (final date in dates)
      for (final slot in timeRange.slots)
        DateTime(date.year, date.month, date.day, 0, slot.inMinutes),
  ];

  /// 예: 2개 항목을 채우면 투표를 시작할 수 있어요. 다 채웠으면 null 입니다.
  String? get missingHint =>
      missingCount == 0 ? null : '$missingCount개 항목을 채우면 투표를 시작할 수 있어요';

  String? get titleError =>
      showErrors && _titleMissing ? '일정 이름을 입력해 주세요' : null;

  String? get datesError =>
      showErrors && dates.isEmpty ? '후보 날짜를 하나 이상 골라 주세요' : null;

  /// 지난 마감은 고르자마자 알려 주고, 빈 마감은 시작 버튼을 누른 뒤에 알려 줍니다.
  String? get deadlineError {
    if (deadlinePassed) return '투표 마감은 지금 이후로 골라 주세요';
    return showErrors && voteDeadlineAt == null ? '투표 마감을 골라 주세요' : null;
  }

  /// 예: 10/13 화 · 10/14 수. 고른 날짜가 없으면 null 입니다.
  String? get datesLabel => dates.isEmpty
      ? null
      : dates.map((date) => date.shortDateLabel).join(' · ');
}
