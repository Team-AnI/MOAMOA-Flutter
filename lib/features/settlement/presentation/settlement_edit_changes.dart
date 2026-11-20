import '../domain/entities/settlement.dart';

extension SettlementEditChangesX on SettlementEditInput {
  SettlementEditInput changesFrom(SettlementDetail previous) {
    final originalIds = previous.payments
        .map((p) => p.memberId)
        .whereType<int>()
        .toSet();
    final ids = memberIds?.toSet();
    final sameMembers =
        ids == null ||
        ids.length == originalIds.length && ids.containsAll(originalIds);
    return SettlementEditInput(
      title: title == previous.title ? null : title,
      totalAmount: totalAmount == previous.totalAmount ? null : totalAmount,
      memberIds: sameMembers ? null : (ids.toList()..sort()),
      bankName: bankName == previous.bankName ? null : bankName,
      accountNumber: accountNumber == previous.accountNumber
          ? null
          : accountNumber,
      accountHolder: accountHolder == previous.accountHolder
          ? null
          : accountHolder,
      dueAt: dueAt?.isAtSameMomentAs(previous.dueAt) == true ? null : dueAt,
      unlinkSchedule: unlinkSchedule && previous.scheduleId != null,
    );
  }

  bool get isEmpty =>
      title == null &&
      totalAmount == null &&
      memberIds == null &&
      bankName == null &&
      accountNumber == null &&
      accountHolder == null &&
      dueAt == null &&
      !unlinkSchedule;
}
