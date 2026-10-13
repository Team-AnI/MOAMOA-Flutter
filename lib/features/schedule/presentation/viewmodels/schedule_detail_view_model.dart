import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
import 'package:moamoa/features/schedule/domain/usecases/get_schedule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/schedule_providers.dart';

part 'schedule_detail_view_model.g.dart';

/// 일정 한 건의 상세 정보
@Riverpod(keepAlive: true)
class ScheduleDetailViewModel extends _$ScheduleDetailViewModel {
  @override
  Future<Schedule> build({required int meetingId, required int scheduleId}) {
    return ref.read(getScheduleProvider)(
      GetScheduleParams(meetingId: meetingId, scheduleId: scheduleId),
    );
  }
}
