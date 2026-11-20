import '../../../../core/errors/api_error_code.dart';
import '../../../../core/errors/api_exception.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/create_settlement_input.dart';
import '../repositories/settlement_repository.dart';
import 'settlement_input_validation.dart';

final class CreateSettlementParams extends Params {
  const CreateSettlementParams({
    required this.meetingId,
    this.scheduleId,
    this.replacesSettlementId,
    required this.title,
    required this.amount,
    required this.memberIds,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolder,
    this.dueAt,
    this.postNotice = false,
  });
  final int meetingId;
  final int? scheduleId;
  final int? replacesSettlementId;
  final String title, amount, bankName, accountNumber, accountHolder;
  final List<int> memberIds;
  final DateTime? dueAt;
  final bool postNotice;
  @override
  List<Object?> get props => [
    meetingId,
    scheduleId,
    replacesSettlementId,
    title,
    amount,
    memberIds,
    bankName,
    accountNumber,
    accountHolder,
    dueAt,
    postNotice,
  ];
}

abstract class CreateSettlement extends Usecase<int, CreateSettlementParams> {}

final class CreateSettlementImpl implements CreateSettlement {
  const CreateSettlementImpl({
    required SettlementRepository settlementRepository,
  }) : _settlementRepository = settlementRepository;
  final SettlementRepository _settlementRepository;
  @override
  Future<int> call(CreateSettlementParams params) async {
    final errors = [
      SettlementInputValidation.title(params.title),
      SettlementInputValidation.amount(params.amount),
      SettlementInputValidation.bankName(params.bankName),
      SettlementInputValidation.accountNumber(params.accountNumber),
      SettlementInputValidation.accountHolder(params.accountHolder),
    ];
    final message = errors.whereType<String>().firstOrNull;
    if (message != null) {
      throw ApiException(code: ApiErrorCode.validation, message: message);
    }
    if (params.memberIds.isEmpty || params.dueAt == null) {
      throw const ApiException(
        code: ApiErrorCode.validation,
        message: '구성원과 납부 기한을 선택해 주세요.',
      );
    }
    if (params.memberIds.any((id) => id <= 0) ||
        params.memberIds.toSet().length != params.memberIds.length) {
      throw const ApiException(
        code: ApiErrorCode.validation,
        message: '정산 대상 구성원을 다시 확인해 주세요.',
      );
    }
    final amount = SettlementInputValidation.parseAmount(params.amount)!;
    if (amount < params.memberIds.length) {
      throw const ApiException(
        code: ApiErrorCode.validation,
        message: '총 금액은 정산 대상 인원보다 적을 수 없어요.',
      );
    }
    return _settlementRepository.create(
      CreateSettlementInput(
        meetingId: params.meetingId,
        replacesSettlementId: params.replacesSettlementId,
        scheduleId: params.scheduleId,
        title: params.title.trim(),
        totalAmount: amount,
        memberIds: params.memberIds,
        bankName: params.bankName.trim(),
        accountNumber: params.accountNumber.trim(),
        accountHolder: params.accountHolder.trim(),
        dueAt: params.dueAt!,
        postNotice: params.postNotice,
      ),
    );
  }
}
