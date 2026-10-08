import 'package:moamoa/features/schedule/domain/errors/schedule_validation_exception.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';

/// "일정 생성"의 입력 검증과 저장을 담당합니다.
class CreateSchedule {
  const CreateSchedule(this._repository);

  final ScheduleRepository _repository;

  /// 폼 입력을 그대로 받으므로 [startAt]은 null 일 수 있습니다.
  Future<int> call({
    required int meetingId,
    required String title,
    String? description,
    DateTime? startAt,
    DateTime? endAt,
    String? location,
  }) async {
    final errors = {
      if (title.trim().isEmpty) ScheduleValidationError.titleRequired,
      if (startAt == null) ScheduleValidationError.startAtRequired,
      if (startAt != null && endAt != null && endAt.isBefore(startAt))
        ScheduleValidationError.endBeforeStart,
    };
    if (errors.isNotEmpty) throw ScheduleValidationException(errors);

    return _repository.createSchedule(
      meetingId: meetingId,
      title: title.trim(),
      description: _blankToNull(description),
      startAt: startAt!,
      endAt: endAt,
      location: _blankToNull(location),
    );
  }

  String? _blankToNull(String? value) {
    final trimmed = value?.trim();
    return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
  }
}
