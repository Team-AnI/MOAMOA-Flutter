import 'package:moamoa/core/usecases/usecase.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_create_request.dart';
import 'package:moamoa/features/schedule/domain/errors/schedule_validation_error.dart';
import 'package:moamoa/features/schedule/domain/errors/schedule_validation_exception.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';

/// CreateSchedule 전용 파라미터. 폼 입력을 그대로 받으므로 [startAt] 은 null 일 수 있습니다.
final class CreateScheduleParams extends Params {
  const CreateScheduleParams({
    required this.meetingId,
    required this.title,
    this.description = '',
    this.startAt,
    this.endAt,
    this.location = '',
  });

  final int meetingId;
  final String title;
  final String description;
  final DateTime? startAt;
  final DateTime? endAt;
  final String location;
}

/// "일정 생성"의 입력 검증과 저장을 담당합니다. 생성된 일정 id 를 돌려줍니다.
/// 테스트에서 Fake 로 대체하기 위한 추상 클래스입니다.
abstract class CreateSchedule extends Usecase<int, CreateScheduleParams> {}

final class CreateScheduleImpl implements CreateSchedule {
  CreateScheduleImpl({required this._repository});

  final ScheduleRepository _repository;

  @override
  Future<int> call(CreateScheduleParams params) async {
    final title = params.title.trim();
    final startAt = params.startAt;
    final endAt = params.endAt;

    final errors = {
      if (title.isEmpty) ScheduleValidationError.titleRequired,
      if (startAt == null) ScheduleValidationError.startAtRequired,
      if (startAt != null && endAt != null && endAt.isBefore(startAt))
        ScheduleValidationError.endBeforeStart,
    };
    if (errors.isNotEmpty) throw ScheduleValidationException(errors);

    return _repository.createSchedule(
      ScheduleCreateRequest(
        meetingId: params.meetingId,
        title: title,
        description: params.description.trim(),
        startAt: startAt!,
        endAt: endAt,
        location: params.location.trim(),
      ),
    );
  }
}
