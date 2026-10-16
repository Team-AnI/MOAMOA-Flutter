import 'package:moamoa/core/usecases/usecase.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_update_request.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';

/// UpdateSchedule 전용 파라미터입니다.
/// [original] 은 수정 전 일정으로, 바뀐 필드만 골라 보내는 데 씁니다.
final class UpdateScheduleParams extends Params {
  const UpdateScheduleParams({
    required this.meetingId,
    required this.original,
    required this.title,
    this.description = '',
    required this.startAt,
    this.endAt,
    this.location = '',
  });

  final int meetingId;
  final Schedule original;
  final String title;
  final String description;
  final DateTime startAt;
  final DateTime? endAt;
  final String location;
}

/// "일정 수정"을 담당합니다. 바뀐 필드가 없으면 저장하지 않습니다.
/// 테스트에서 Fake 로 대체하기 위한 추상 클래스입니다.
abstract class UpdateSchedule extends Usecase<void, UpdateScheduleParams> {}

final class UpdateScheduleImpl implements UpdateSchedule {
  UpdateScheduleImpl({required ScheduleRepository scheduleRepository})
    // ignore: prefer_initializing_formals
    : _scheduleRepository = scheduleRepository;

  final ScheduleRepository _scheduleRepository;

  @override
  Future<void> call(UpdateScheduleParams params) async {
    final original = params.original;
    final title = params.title.trim();
    final description = params.description.trim();
    final location = params.location.trim();

    final request = ScheduleUpdateRequest(
      meetingId: params.meetingId,
      scheduleId: original.id,
      title: title == original.title ? null : title,
      description: description == original.description ? null : description,
      startAt: params.startAt == original.startAt ? null : params.startAt,
      endAt: params.endAt == original.endAt ? null : params.endAt,
      location: location == original.location ? null : location,
    );
    if (request ==
        ScheduleUpdateRequest(
          meetingId: params.meetingId,
          scheduleId: original.id,
        )) {
      return;
    }
    await _scheduleRepository.updateSchedule(request);
  }
}
