import '../../../../core/usecases/usecase.dart';
import '../entities/settlement.dart';
import '../repositories/settlement_repository.dart';
import 'regular_due_validation.dart';

final class CreateRegularDueParams extends Params {
  const CreateRegularDueParams({required this.meetingId, required this.input});
  final int meetingId;
  final RegularDueInput input;
  @override
  List<Object?> get props => [meetingId, input];
}

abstract class CreateRegularDue extends Usecase<int, CreateRegularDueParams> {}

final class CreateRegularDueImpl implements CreateRegularDue {
  const CreateRegularDueImpl({
    required SettlementRepository settlementRepository,
  }) : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<int> call(CreateRegularDueParams params) async {
    final v = params.input;
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
    return _settlementRepository.createRegularDue(params.meetingId, v);
  }
}
