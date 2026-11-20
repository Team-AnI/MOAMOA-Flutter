import '../domain/entities/regular_due.dart';
import '../domain/entities/regular_due_input.dart';
import '../domain/entities/regular_due_update.dart';

extension RegularDueChanges on RegularDueInput {
  RegularDueUpdate changesFrom(
    RegularDue previous, {
    bool applyToCurrentSettlement = false,
  }) => RegularDueUpdate(
    title: title != previous.title ? title : null,
    amount: amount != previous.amount ? amount : null,
    cycle: cycle != previous.cycle ? cycle : null,
    cycleDay: cycle != previous.cycle || cycleDay != previous.cycleDay
        ? cycleDay
        : null,
    sendTime: sendTime != previous.sendTime ? sendTime : null,
    dueDays: dueDays != previous.dueDays ? dueDays : null,
    bankName: bankName != previous.bankName ? bankName : null,
    accountNumber: accountNumber != previous.accountNumber
        ? accountNumber
        : null,
    accountHolder: accountHolder != previous.accountHolder
        ? accountHolder
        : null,
    isActive: isActive != previous.isActive ? isActive : null,
    postNotice: postNotice != previous.postNotice ? postNotice : null,
    applyToCurrentSettlement: applyToCurrentSettlement,
  );
}
