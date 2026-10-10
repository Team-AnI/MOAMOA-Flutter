import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule_detail_request.dart';

import '../providers/schedule_providers.dart';

/// 일정 한 건의 상세 정보
class ScheduleDetailViewModel extends AsyncNotifier<Schedule> {
  ScheduleDetailViewModel(this.request);

  final ScheduleDetailRequest request;

  @override
  Future<Schedule> build() {
    return ref.read(scheduleRepositoryProvider).getSchedule(request);
  }
}
