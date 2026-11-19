import '../../../../core/usecases/usecase.dart';
import '../entities/settlement.dart';
import '../repositories/settlement_repository.dart';

final class GetSettlementParams extends Params {
  const GetSettlementParams({
    required this.meetingId,
    required this.settlementId,
  });
  final int meetingId, settlementId;
  @override
  List<Object?> get props => [meetingId, settlementId];
}

abstract class GetSettlement
    extends Usecase<SettlementDetail, GetSettlementParams> {}

final class GetSettlementImpl implements GetSettlement {
  const GetSettlementImpl({required SettlementRepository settlementRepository})
    : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<SettlementDetail> call(GetSettlementParams params) =>
      _settlementRepository.detail(params.meetingId, params.settlementId);
}
