import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:moamoa/features/schedule/domain/usecases/create_schedule.dart';
import 'package:moamoa/features/schedule/domain/usecases/get_schedule.dart';
import 'package:moamoa/features/schedule/domain/usecases/get_schedules.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'schedule_providers.g.dart';

/// TODO: API 연동 시 실제 API 를 호출하는 구현체로 교체합니다.
/// 그 전까지는 override 하지 않으면 읽을 수 없습니다. (테스트는 Fake 를 주입)
@Riverpod(keepAlive: true)
ScheduleRepository scheduleRepository(Ref ref) =>
    throw UnimplementedError('API 연동 시 구현체를 연결합니다.');

@Riverpod(keepAlive: true)
CreateSchedule createSchedule(Ref ref) =>
    CreateScheduleImpl(repository: ref.watch(scheduleRepositoryProvider));

@Riverpod(keepAlive: true)
GetSchedules getSchedules(Ref ref) =>
    GetSchedulesImpl(repository: ref.watch(scheduleRepositoryProvider));

@Riverpod(keepAlive: true)
GetSchedule getSchedule(Ref ref) =>
    GetScheduleImpl(repository: ref.watch(scheduleRepositoryProvider));

/// 현재 사용자가 이 모임의 관리자인지 알려줍니다.
/// 권한 정보가 연동되기 전에는 관리자가 아닌 것으로 보고 일정 만들기 버튼을 숨깁니다.
/// TODO(#29): 모임 상세 응답의 myRole 로 교체합니다.
@Riverpod(keepAlive: true)
bool scheduleAdmin(Ref ref) => false;
