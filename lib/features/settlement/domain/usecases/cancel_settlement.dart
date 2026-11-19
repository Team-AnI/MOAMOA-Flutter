import '../../../../core/usecases/usecase.dart';
import '../../../../core/errors/api_exception.dart';
import '../../../../core/errors/api_error_code.dart';
import '../repositories/settlement_repository.dart';

final class CancelSettlementParams extends Params {
  const CancelSettlementParams({
    required this.meetingId,
    required this.settlementId,
    this.reason,
  });
  final int meetingId, settlementId;
  final String? reason;
  @override
  List<Object?> get props => [meetingId, settlementId, reason];
}

abstract class CancelSettlement extends Usecase<void, CancelSettlementParams> {}

final class CancelSettlementImpl implements CancelSettlement {
  const CancelSettlementImpl({
    required SettlementRepository settlementRepository,
  }) : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<void> call(CancelSettlementParams params) async {
    if ((params.reason?.length ?? 0) > 255) {
      throw const ApiException(
        code: ApiErrorCode.validation,
        message: '취소 사유는 255자 이하여야 해요.',
      );
    }
    return _settlementRepository.cancelSettlement(
      params.meetingId,
      params.settlementId,
      reason: params.reason?.trim().isEmpty == true
          ? null
          : params.reason?.trim(),
    );
  }
}
