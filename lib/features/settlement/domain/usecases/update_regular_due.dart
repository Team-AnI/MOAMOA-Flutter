import '../../../../core/usecases/usecase.dart';
import '../entities/current_settlement_application.dart';
import '../entities/regular_due_update.dart';
import '../repositories/settlement_repository.dart';
import 'regular_due_validation.dart';

final class UpdateRegularDueParams extends Params {
  const UpdateRegularDueParams({
    required this.meetingId,
    required this.regularDuesId,
    required this.changes,
  });
  final int meetingId, regularDuesId;
  final RegularDueUpdate changes;
  @override
  List<Object?> get props => [meetingId, regularDuesId, changes];
}

abstract class UpdateRegularDue
    extends Usecase<CurrentSettlementApplication, UpdateRegularDueParams> {}

final class UpdateRegularDueImpl implements UpdateRegularDue {
  const UpdateRegularDueImpl({
    required SettlementRepository settlementRepository,
  }) : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<CurrentSettlementApplication> call(
    UpdateRegularDueParams params,
  ) async {
    final v = params.changes;
    RegularDueValidation.check(
      title: v.title,
      amount: v.amount,
      cycle: v.cycle,
      cycleDay: v.cycleDay,
      sendTime: v.sendTime,
      dueDays: v.dueDays,
      bankName: v.bankName,
      accountNumber: v.accountNumber,
      accountHolder: v.accountHolder,
    );
    final result = await _settlementRepository.updateRegularDue(
      params.meetingId,
      params.regularDuesId,
      v,
    );
    if (!v.applyToCurrentSettlement) {
      return CurrentSettlementApplication.notRequested;
    }
    return switch (result) {
      true => CurrentSettlementApplication.applied,
      false => CurrentSettlementApplication.notApplied,
      null => CurrentSettlementApplication.unknown,
    };
  }
}
