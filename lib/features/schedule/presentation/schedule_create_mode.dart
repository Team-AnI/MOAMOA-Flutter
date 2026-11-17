/// 일정 만들기 방식입니다. 방식 선택 시트가 고른 값을 돌려줍니다.
enum ScheduleCreateMode {
  /// 시작 일시를 직접 입력해 바로 만듭니다.
  direct,

  /// 후보 시간을 투표로 정합니다.
  vote,
}

/// 방식 선택 시트에 보여줄 문구
extension ScheduleCreateModeLabelX on ScheduleCreateMode {
  String get title => switch (this) {
    ScheduleCreateMode.direct => '바로 정하기',
    ScheduleCreateMode.vote => '투표로 정하기',
  };

  String get description => switch (this) {
    ScheduleCreateMode.direct => '시작 일시를 직접 입력해요',
    ScheduleCreateMode.vote => '후보 시간을 투표로 정해요',
  };
}
