import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_create_view_model.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_detail_view_model.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_list_view_model.dart';

/// TODO: API 연동 시 실제 API 를 호출하는 구현체로 교체합니다.
final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => ScheduleRepositoryImpl(),
);

/// 현재 사용자가 이 모임의 관리자인지.
/// TODO(#29): 모임 상세 응답의 myRole 로 교체합니다. (지금은 개발용으로 항상 true)
final scheduleAdminProvider = Provider<bool>((ref) => true);

final scheduleListProvider =
    AsyncNotifierProvider.family<
      ScheduleListViewModel,
      List<Schedule>,
      ScheduleListArgs
    >(ScheduleListViewModel.new);

final scheduleDetailProvider =
    AsyncNotifierProvider.family<
      ScheduleDetailViewModel,
      Schedule,
      ScheduleDetailArgs
    >(ScheduleDetailViewModel.new);

/// 인자는 일정을 만들 모임의 id.
/// autoDispose: 화면을 닫으면 이전 제출 결과(성공 id, 오류)가 남지 않게 초기화합니다.
final scheduleCreateProvider = AsyncNotifierProvider.autoDispose
    .family<ScheduleCreateViewModel, int?, int>(ScheduleCreateViewModel.new);
