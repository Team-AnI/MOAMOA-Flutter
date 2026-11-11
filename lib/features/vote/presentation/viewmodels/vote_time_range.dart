import 'package:freezed_annotation/freezed_annotation.dart';

import '../vote_format.dart';
import 'vote_slot_interval.dart';

part 'vote_time_range.freezed.dart';

/// 후보 날짜마다 같은 시각들로 후보를 만들 때 쓰는 하루 중 시간 범위입니다.
///
/// [start] 부터 [interval] 마다 [end] 전까지가 후보 시각입니다. (예: 18:00~20:30, 30분 → 5칸)
@freezed
abstract class VoteTimeRange with _$VoteTimeRange {
  const factory VoteTimeRange({
    /// 하루 중 시작 시각 (0:00 부터 지난 시간)
    @Default(Duration(hours: 18)) Duration start,

    /// 하루 중 종료 시각. 이 시각은 후보에 들어가지 않습니다.
    @Default(Duration(hours: 20, minutes: 30)) Duration end,
    @Default(VoteSlotInterval.thirtyMinutes) VoteSlotInterval interval,
  }) = _VoteTimeRange;
}

extension VoteTimeRangeX on VoteTimeRange {
  /// 종료가 시작보다 늦어야 후보를 만들 수 있습니다.
  bool get isValid => end > start;

  /// 후보 시각들. 범위가 잘못됐으면 비어 있습니다.
  List<Duration> get slots => [
    for (var time = start; time < end; time += interval.duration) time,
  ];

  /// 예: 18:00 ~ 20:30 · 30분 단위
  String get label => '${start.hhmm} ~ ${end.hhmm} · ${interval.label} 단위';

  /// 예: 18:00부터 20:30까지 5칸으로 투표해요
  String get summary => '${start.hhmm}부터 ${end.hhmm}까지 ${slots.length}칸으로 투표해요';
}
