/// 일정 만들기 제출 과정의 현재 단계입니다.
enum ScheduleCreateStatus {
  /// 아직 제출하지 않았습니다.
  initial,

  /// 제출 중입니다. 버튼이 비활성화되고 중복 제출은 무시합니다.
  submitting,

  /// 생성에 성공했습니다. 화면을 닫습니다.
  success,

  /// 입력 오류 또는 저장 실패입니다.
  failure,
}
