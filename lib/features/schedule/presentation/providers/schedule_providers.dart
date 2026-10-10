import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_detail_request.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_list_request.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:moamoa/features/schedule/domain/usecases/create_schedule.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_calendar_view_model.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_create_state.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_create_view_model.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_detail_view_model.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_list_view_model.dart';

/// TODO: API 연동 시 실제 API 를 호출하는 구현체로 교체합니다.
/// 그 전까지는 override 하지 않으면 읽을 수 없습니다. (테스트는 Fake 를 주입)
final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => throw UnimplementedError('API 연동 시 구현체를 연결합니다.'),
);

final createScheduleProvider = Provider<CreateSchedule>(
  (ref) =>
      CreateScheduleImpl(repository: ref.watch(scheduleRepositoryProvider)),
);

/// 현재 사용자가 이 모임의 관리자인지 알려줍니다.
/// 권한 정보가 연동되기 전에는 관리자가 아닌 것으로 보고 일정 만들기 버튼을 숨깁니다.
/// TODO(#29): 모임 상세 응답의 myRole 로 교체합니다.
final scheduleAdminProvider = Provider<bool>((ref) => false);

final scheduleListProvider =
    AsyncNotifierProvider.family<
      ScheduleListViewModel,
      List<Schedule>,
      ScheduleListRequest
    >(ScheduleListViewModel.new);

final scheduleDetailProvider =
    AsyncNotifierProvider.family<
      ScheduleDetailViewModel,
      Schedule,
      ScheduleDetailRequest
    >(ScheduleDetailViewModel.new);

/// 인자는 일정을 만들 모임의 id 입니다.
/// autoDispose: 화면을 닫으면 이전 제출 결과(성공 id, 오류)가 남지 않게 초기화합니다.
final scheduleCreateProvider = NotifierProvider.autoDispose
    .family<ScheduleCreateViewModel, ScheduleCreateState, int>(
      ScheduleCreateViewModel.new,
    );

/// 캘린더 탭의 월/선택 날짜. 목록 페이지가 구독을 유지하므로 탭을 오가도 값이 남습니다.
final scheduleCalendarProvider =
    NotifierProvider.autoDispose<
      ScheduleCalendarViewModel,
      ScheduleCalendarState
    >(ScheduleCalendarViewModel.new);
