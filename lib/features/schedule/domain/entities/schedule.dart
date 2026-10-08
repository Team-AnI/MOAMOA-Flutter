import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule.freezed.dart';

@freezed
abstract class Schedule with _$Schedule {
  const factory Schedule({
    required int id,
    required String title,
    String? description,
    required DateTime startAt,
    DateTime? endAt,
    String? location,
  }) = _Schedule;
}
