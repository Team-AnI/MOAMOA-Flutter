import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/usecases/settlement_input_validation.dart';

part 'settlement_account_input.freezed.dart';

@freezed
abstract class SettlementAccountInput with _$SettlementAccountInput {
  const factory SettlementAccountInput({
    @Default('') String bankName,
    @Default('') String accountNumber,
    @Default('') String accountHolder,
  }) = _SettlementAccountInput;
}

extension SettlementAccountInputX on SettlementAccountInput {
  String get label => bankName.isEmpty
      ? '받을 계좌 입력'
      : '$bankName $accountNumber · $accountHolder';
  bool get isValid =>
      SettlementInputValidation.bankName(bankName) == null &&
      SettlementInputValidation.accountNumber(accountNumber) == null &&
      SettlementInputValidation.accountHolder(accountHolder) == null;
}
