import 'package:moamoa/core/usecases/usecase.dart';
import 'package:moamoa/features/schedule/domain/entities/created_schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_create_request.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';

/// CreateSchedule 전용 파라미터입니다.
final class CreateScheduleParams extends Params {
  const CreateScheduleParams({
    required this.meetingId,
    required this.title,
    this.description = '',
    required this.startAt,
    this.endAt,
    this.location = '',
  });

  final int meetingId;
  final String title;
  final String description;
  final DateTime startAt;
  final DateTime? endAt;
  final String location;
}

/// "일정 생성"을 담당합니다. 생성된 일정을 돌려줍니다.
/// 테스트에서 Fake 로 대체하기 위한 추상 클래스입니다.
abstract class CreateSchedule
    extends Usecase<CreatedSchedule, CreateScheduleParams> {}

final class CreateScheduleImpl implements CreateSchedule {
  CreateScheduleImpl({required this._repository});

  final ScheduleRepository _repository;

  @override
  Future<CreatedSchedule> call(CreateScheduleParams params) async {
    return _repository.createSchedule(
      ScheduleCreateRequest(
        meetingId: params.meetingId,
        title: params.title.trim(),
        description: params.description.trim(),
        startAt: params.startAt,
        endAt: params.endAt,
        location: params.location.trim(),
      ),
    );
  }
}
