import 'package:moamoa/core/usecases/usecase.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_update_request.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';

/// UpdateSchedule 전용 파라미터입니다.
/// 바뀐 필드만 값이 있고, null 인 필드는 바꾸지 않습니다.
final class UpdateScheduleParams extends Params {
  const UpdateScheduleParams({
    required this.meetingId,
    required this.scheduleId,
    this.title,
    this.description,
    this.startAt,
    this.endAt,
    this.location,
  });

  final int meetingId;
  final int scheduleId;
  final String? title;
  final String? description;
  final DateTime? startAt;
  final DateTime? endAt;
  final String? location;

  @override
  List<Object?> get props => [
    meetingId,
    scheduleId,
    title,
    description,
    startAt,
    endAt,
    location,
  ];
}

/// "일정 수정"을 담당합니다.
/// 테스트에서 Fake 로 대체하기 위한 추상 클래스입니다.
abstract class UpdateSchedule extends Usecase<void, UpdateScheduleParams> {}

final class UpdateScheduleImpl implements UpdateSchedule {
  UpdateScheduleImpl({required ScheduleRepository scheduleRepository})
    // ignore: prefer_initializing_formals
    : _scheduleRepository = scheduleRepository;

  final ScheduleRepository _scheduleRepository;

  @override
  Future<void> call(UpdateScheduleParams params) async {
    return _scheduleRepository.updateSchedule(
      ScheduleUpdateRequest(
        meetingId: params.meetingId,
        scheduleId: params.scheduleId,
        title: params.title,
        description: params.description,
        startAt: params.startAt,
        endAt: params.endAt,
        location: params.location,
      ),
    );
  }
}
