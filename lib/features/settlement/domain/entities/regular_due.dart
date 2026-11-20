import 'package:freezed_annotation/freezed_annotation.dart';

import 'dues_cycle.dart';

part 'regular_due.freezed.dart';

@freezed
abstract class RegularDue with _$RegularDue {
  const factory RegularDue({
    required int id,
    required String title,
    required int amount,
    required DuesCycle cycle,
    required String cycleDay,
    required String sendTime,
    required int dueDays,
    required String bankName,
    required String accountNumber,
    required String accountHolder,
    required bool isActive,
    required bool postNotice,
  }) = _RegularDue;
}
