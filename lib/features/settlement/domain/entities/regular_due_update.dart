import 'package:freezed_annotation/freezed_annotation.dart';

import 'dues_cycle.dart';

part 'regular_due_update.freezed.dart';

@freezed
abstract class RegularDueUpdate with _$RegularDueUpdate {
  const RegularDueUpdate._();
  const factory RegularDueUpdate({
    String? title,
    int? amount,
    DuesCycle? cycle,
    String? cycleDay,
    String? sendTime,
    int? dueDays,
    String? bankName,
    String? accountNumber,
    String? accountHolder,
    bool? isActive,
    bool? postNotice,
    @Default(false) bool applyToCurrentSettlement,
  }) = _RegularDueUpdate;
  bool get isEmpty =>
      title == null &&
      amount == null &&
      cycle == null &&
      cycleDay == null &&
      sendTime == null &&
      dueDays == null &&
      bankName == null &&
      accountNumber == null &&
      accountHolder == null &&
      isActive == null &&
      postNotice == null &&
      !applyToCurrentSettlement;
}
