import '../../../../core/usecases/usecase.dart';
import '../entities/settlement.dart';
import '../repositories/settlement_repository.dart';

final class GetRegularDuesParams extends Params {
  const GetRegularDuesParams({required this.meetingId});
  final int meetingId;
  @override
  List<Object?> get props => [meetingId];
}

abstract class GetRegularDues
    extends Usecase<List<RegularDue>, GetRegularDuesParams> {}

final class GetRegularDuesImpl implements GetRegularDues {
  const GetRegularDuesImpl({required SettlementRepository settlementRepository})
    : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<List<RegularDue>> call(GetRegularDuesParams params) async {
    return _settlementRepository.listRegularDues(params.meetingId);
  }
}
