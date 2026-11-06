import 'package:moamoa/core/usecases/usecase.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_list_request.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';

/// GetSchedules 전용 파라미터입니다. [startDate]~[endDate](포함) 기간을 조회합니다.
final class GetSchedulesParams extends Params {
  const GetSchedulesParams({
    required this.meetingId,
    required this.startDate,
    required this.endDate,
  });

  final int meetingId;
  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object?> get props => [meetingId, startDate, endDate];
}

/// "기간 내 일정 목록 조회"를 담당합니다. 시작 일시 순으로 돌려줍니다.
/// 테스트에서 Fake 로 대체하기 위한 추상 클래스입니다.
abstract class GetSchedules
    extends Usecase<List<Schedule>, GetSchedulesParams> {}

final class GetSchedulesImpl implements GetSchedules {
  GetSchedulesImpl({required ScheduleRepository scheduleRepository})
    // ignore: prefer_initializing_formals
    : _scheduleRepository = scheduleRepository;

  final ScheduleRepository _scheduleRepository;

  @override
  Future<List<Schedule>> call(GetSchedulesParams params) async {
    return _scheduleRepository.getSchedules(
      ScheduleListRequest(
        meetingId: params.meetingId,
        startDate: params.startDate,
        endDate: params.endDate,
      ),
    );
  }
}
