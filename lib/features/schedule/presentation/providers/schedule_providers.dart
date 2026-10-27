import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_list_request.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:moamoa/features/schedule/domain/usecases/create_schedule.dart';
import 'package:moamoa/features/schedule/domain/usecases/delete_schedule.dart';
import 'package:moamoa/features/schedule/domain/usecases/get_schedule.dart';
import 'package:moamoa/features/schedule/domain/usecases/get_schedules.dart';
import 'package:moamoa/features/schedule/domain/usecases/update_schedule.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_calendar_state.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_calendar_view_model.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_create_state.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_create_view_model.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_delete_state.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_delete_view_model.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_detail_view_model.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_edit_state.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_edit_view_model.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_list_view_model.dart';

/// TODO: API 연동 시 실제 API 를 호출하는 구현체로 교체합니다.
/// 그 전까지는 override 하지 않으면 읽을 수 없습니다. (테스트는 Fake 를 주입)
final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => throw UnimplementedError('API 연동 시 구현체를 연결합니다.'),
);

final createScheduleProvider = Provider<CreateSchedule>(
  (ref) => CreateScheduleImpl(
    scheduleRepository: ref.watch(scheduleRepositoryProvider),
  ),
);

final getSchedulesProvider = Provider<GetSchedules>(
  (ref) => GetSchedulesImpl(
    scheduleRepository: ref.watch(scheduleRepositoryProvider),
  ),
);

final getScheduleProvider = Provider<GetSchedule>(
  (ref) => GetScheduleImpl(
    scheduleRepository: ref.watch(scheduleRepositoryProvider),
  ),
);

final updateScheduleProvider = Provider<UpdateSchedule>(
  (ref) => UpdateScheduleImpl(
    scheduleRepository: ref.watch(scheduleRepositoryProvider),
  ),
);

final deleteScheduleProvider = Provider<DeleteSchedule>(
  (ref) => DeleteScheduleImpl(
    scheduleRepository: ref.watch(scheduleRepositoryProvider),
  ),
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
    >(
      (request) => ScheduleListViewModel(
        meetingId: request.meetingId,
        startDate: request.startDate,
        endDate: request.endDate,
      ),
    );

/// 상세·수정·취소 Provider 가 키로 쓰는 일정 식별자입니다.
typedef ScheduleArgs = ({int meetingId, int scheduleId});

final scheduleDetailProvider =
    AsyncNotifierProvider.family<
      ScheduleDetailViewModel,
      Schedule,
      ScheduleArgs
    >(
      (args) => ScheduleDetailViewModel(
        meetingId: args.meetingId,
        scheduleId: args.scheduleId,
      ),
    );

/// 인자는 일정을 만들 모임의 id 입니다.
/// autoDispose: 화면을 닫으면 이전 제출 결과(성공 id, 오류)가 남지 않게 초기화합니다.
final scheduleCreateProvider = NotifierProvider.autoDispose
    .family<ScheduleCreateViewModel, ScheduleCreateState, int>(
      (meetingId) => ScheduleCreateViewModel(meetingId: meetingId),
    );

/// 인자는 수정할 일정입니다.
/// autoDispose: 화면을 닫으면 이전 제출 결과(성공, 오류)가 남지 않게 초기화합니다.
final scheduleEditProvider = NotifierProvider.autoDispose
    .family<ScheduleEditViewModel, ScheduleEditState, ScheduleArgs>(
      (args) => ScheduleEditViewModel(
        meetingId: args.meetingId,
        scheduleId: args.scheduleId,
      ),
    );

/// 인자는 취소할 일정입니다.
/// autoDispose: 화면을 닫으면 이전 요청 결과(성공, 오류)가 남지 않게 초기화합니다.
final scheduleDeleteProvider = NotifierProvider.autoDispose
    .family<ScheduleDeleteViewModel, ScheduleDeleteState, ScheduleArgs>(
      (args) => ScheduleDeleteViewModel(
        meetingId: args.meetingId,
        scheduleId: args.scheduleId,
      ),
    );

/// 캘린더 탭의 월/선택 날짜. 목록 페이지가 구독을 유지하므로 탭을 오가도 값이 남습니다.
final scheduleCalendarProvider =
    NotifierProvider.autoDispose<
      ScheduleCalendarViewModel,
      ScheduleCalendarState
    >(ScheduleCalendarViewModel.new);
