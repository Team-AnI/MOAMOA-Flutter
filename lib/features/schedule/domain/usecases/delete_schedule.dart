import 'package:moamoa/core/usecases/usecase.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_delete_request.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';

/// DeleteSchedule 전용 파라미터입니다.
final class DeleteScheduleParams extends Params {
  const DeleteScheduleParams({
    required this.meetingId,
    required this.scheduleId,
  });

  final int meetingId;
  final int scheduleId;
}

/// "일정 취소"를 담당합니다.
/// 테스트에서 Fake 로 대체하기 위한 추상 클래스입니다.
abstract class DeleteSchedule extends Usecase<void, DeleteScheduleParams> {}

final class DeleteScheduleImpl implements DeleteSchedule {
  DeleteScheduleImpl({required ScheduleRepository scheduleRepository})
    // ignore: prefer_initializing_formals
    : _scheduleRepository = scheduleRepository;

  final ScheduleRepository _scheduleRepository;

  @override
  Future<void> call(DeleteScheduleParams params) async {
    return _scheduleRepository.deleteSchedule(
      ScheduleDeleteRequest(
        meetingId: params.meetingId,
        scheduleId: params.scheduleId,
      ),
    );
  }
}
