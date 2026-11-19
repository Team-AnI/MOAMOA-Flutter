import '../../../../core/usecases/usecase.dart';
import '../repositories/settlement_repository.dart';

final class DeleteRegularDueParams extends Params {
  const DeleteRegularDueParams({
    required this.meetingId,
    required this.regularDuesId,
  });
  final int meetingId, regularDuesId;
  @override
  List<Object?> get props => [meetingId, regularDuesId];
}

abstract class DeleteRegularDue extends Usecase<void, DeleteRegularDueParams> {}

final class DeleteRegularDueImpl implements DeleteRegularDue {
  const DeleteRegularDueImpl({
    required SettlementRepository settlementRepository,
  }) : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<void> call(DeleteRegularDueParams params) async {
    return _settlementRepository.deleteRegularDue(
      params.meetingId,
      params.regularDuesId,
    );
  }
}
