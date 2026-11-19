import '../../../../core/usecases/usecase.dart';
import '../../../../core/errors/api_exception.dart';
import '../../../../core/errors/api_error_code.dart';
import '../entities/settlement_edit_input.dart';
import '../repositories/settlement_repository.dart';
import 'settlement_input_validation.dart';

final class UpdateSettlementParams extends Params {
  const UpdateSettlementParams({
    required this.meetingId,
    required this.settlementId,
    required this.changes,
    required this.memberCount,
  });
  final int meetingId, settlementId, memberCount;
  final SettlementEditInput changes;
  @override
  List<Object?> get props => [meetingId, settlementId, changes, memberCount];
}

abstract class UpdateSettlement extends Usecase<void, UpdateSettlementParams> {}

final class UpdateSettlementImpl implements UpdateSettlement {
  const UpdateSettlementImpl({
    required SettlementRepository settlementRepository,
  }) : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<void> call(UpdateSettlementParams params) async {
    final v = params.changes;
    final errors = [
      if (v.title != null) SettlementInputValidation.title(v.title!),
      if (v.bankName != null) SettlementInputValidation.bankName(v.bankName!),
      if (v.accountNumber != null)
        SettlementInputValidation.accountNumber(v.accountNumber!),
      if (v.accountHolder != null)
        SettlementInputValidation.accountHolder(v.accountHolder!),
    ];
    final error = errors.whereType<String>().firstOrNull;
    if (error != null) {
      throw ApiException(code: ApiErrorCode.validation, message: error);
    }
    if (v.totalAmount != null &&
        (v.totalAmount! < 1 ||
            v.totalAmount! > 2147483647 ||
            v.totalAmount! < (v.memberIds?.length ?? params.memberCount))) {
      throw const ApiException(
        code: ApiErrorCode.validation,
        message: '총 금액을 확인해 주세요.',
      );
    }
    if (v.memberIds != null &&
        (v.memberIds!.isEmpty ||
            v.memberIds!.any((id) => id <= 0) ||
            v.memberIds!.toSet().length != v.memberIds!.length)) {
      throw const ApiException(
        code: ApiErrorCode.validation,
        message: '정산 대상자를 확인해 주세요.',
      );
    }
    return _settlementRepository.updateSettlement(
      params.meetingId,
      params.settlementId,
      v,
    );
  }
}
