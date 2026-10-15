import 'package:moamoa/core/usecases/usecase.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_detail_request.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';

/// GetSchedule 전용 파라미터입니다.
final class GetScheduleParams extends Params {
  const GetScheduleParams({required this.meetingId, required this.scheduleId});

  final int meetingId;
  final int scheduleId;
}

/// "일정 한 건 조회"를 담당합니다.
/// 테스트에서 Fake 로 대체하기 위한 추상 클래스입니다.
abstract class GetSchedule extends Usecase<Schedule, GetScheduleParams> {}

final class GetScheduleImpl implements GetSchedule {
  GetScheduleImpl({required ScheduleRepository scheduleRepository})
    // ignore: prefer_initializing_formals
    : _scheduleRepository = scheduleRepository;

  final ScheduleRepository _scheduleRepository;

  @override
  Future<Schedule> call(GetScheduleParams params) async {
    return _scheduleRepository.getSchedule(
      ScheduleDetailRequest(
        meetingId: params.meetingId,
        scheduleId: params.scheduleId,
      ),
    );
  }
}
