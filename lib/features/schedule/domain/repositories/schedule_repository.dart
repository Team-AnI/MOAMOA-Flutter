import 'package:moamoa/features/schedule/domain/entities/created_schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_create_request.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_detail_request.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_list_request.dart';

abstract class ScheduleRepository {
  /// 일정을 만들고 생성된 일정을 돌려줍니다.
  Future<CreatedSchedule> createSchedule(ScheduleCreateRequest request);

  /// 요청한 기간의 일정을 시작 일시 순으로 돌려줍니다.
  Future<List<Schedule>> getSchedules(ScheduleListRequest request);

  /// 요청한 일정 한 건을 돌려줍니다.
  Future<Schedule> getSchedule(ScheduleDetailRequest request);
}
