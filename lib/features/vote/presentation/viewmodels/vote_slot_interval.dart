/// 후보 시간 사이의 간격입니다. (후보 시간 시트의 "투표 간격")
enum VoteSlotInterval {
  thirtyMinutes(Duration(minutes: 30)),
  oneHour(Duration(hours: 1));

  const VoteSlotInterval(this.duration);

  final Duration duration;
}

/// 화면에 보여줄 간격 이름입니다.
extension VoteSlotIntervalLabelX on VoteSlotInterval {
  String get label => switch (this) {
    VoteSlotInterval.thirtyMinutes => '30분',
    VoteSlotInterval.oneHour => '1시간',
  };
}
