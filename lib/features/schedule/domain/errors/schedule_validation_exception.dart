/// 일정 입력 검증 실패 사유
enum ScheduleValidationError { titleRequired, startAtRequired, endBeforeStart }

/// 일정 입력이 규칙에 맞지 않을 때 던집니다. 실패 사유는 한 번에 모두 담깁니다.
class ScheduleValidationException implements Exception {
  const ScheduleValidationException(this.errors);

  final Set<ScheduleValidationError> errors;
}
