import '../../../../core/usecases/usecase.dart';
import '../entities/settlement.dart';
import '../repositories/settlement_repository.dart';

final class GetSettlementsParams extends Params {
  const GetSettlementsParams({required this.meetingId});
  final int meetingId;
  @override
  List<Object?> get props => [meetingId];
}

abstract class GetSettlements
    extends Usecase<List<Settlement>, GetSettlementsParams> {}

final class GetSettlementsImpl implements GetSettlements {
  const GetSettlementsImpl({required SettlementRepository settlementRepository})
    : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<List<Settlement>> call(GetSettlementsParams params) =>
      _settlementRepository.list(params.meetingId);
}
