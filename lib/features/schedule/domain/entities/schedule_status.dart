/// 일정의 상태입니다. (API 일정 목록·상세 status)
enum ScheduleStatus {
  /// 관리자가 시간을 바로 정해 만든 일정입니다.
  scheduled,

  /// 후보 시간으로 투표 중인 일정입니다. 시작 일시에는 가장 이른 후보 시간이 임시로 들어 있습니다.
  voting,

  /// 투표로 시간을 확정한 일정입니다.
  confirmed,

  /// 취소된 일정입니다.
  canceled,
}
