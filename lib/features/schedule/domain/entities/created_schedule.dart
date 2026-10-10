import 'package:freezed_annotation/freezed_annotation.dart';

part 'created_schedule.freezed.dart';

/// 일정을 만든 결과. API 의 일정 생성 응답(id, 제목, 시작 일시)에 대응합니다.
/// 응답에 필드가 늘어나면 여기에 추가 합니다.
@freezed
abstract class CreatedSchedule with _$CreatedSchedule {
  const factory CreatedSchedule({
    required int id,
    required String title,
    required DateTime startAt,
  }) = _CreatedSchedule;
}
