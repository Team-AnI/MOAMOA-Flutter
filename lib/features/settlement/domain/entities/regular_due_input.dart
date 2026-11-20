import 'package:freezed_annotation/freezed_annotation.dart';

import 'dues_cycle.dart';

part 'regular_due_input.freezed.dart';

@freezed
abstract class RegularDueInput with _$RegularDueInput {
  const factory RegularDueInput({
    required String title,
    required int amount,
    required DuesCycle cycle,
    required String cycleDay,
    required String sendTime,
    required int dueDays,
    required String bankName,
    required String accountNumber,
    required String accountHolder,
    required bool postNotice,
    @Default(true) bool isActive,
  }) = _RegularDueInput;
}
