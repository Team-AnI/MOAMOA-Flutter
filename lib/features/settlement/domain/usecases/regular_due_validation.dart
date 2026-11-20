import '../../../../core/errors/api_error_code.dart';
import '../../../../core/errors/api_exception.dart';
import '../entities/dues_cycle.dart';
import 'settlement_input_validation.dart';

class RegularDueValidation {
  static const maxAmount = 5000000;
  static String? title(String value) =>
      SettlementInputValidation.text(value, '회비 이름', 50);
  static String? amount(String value) {
    final number = int.tryParse(value);
    return number == null || number < 1 || number > maxAmount
        ? '1인당 금액은 1~5,000,000원이어야 해요.'
        : null;
  }

  static String? dueDays(String value) {
    final number = int.tryParse(value);
    return number == null ||
            number < 0 ||
            number > SettlementInputValidation.maxServerInt
        ? '납부 기한 일수를 확인해 주세요.'
        : null;
  }

  static void check({
    String? title,
    int? amount,
    DuesCycle? cycle,
    String? cycleDay,
    String? sendTime,
    int? dueDays,
    String? bankName,
    String? accountNumber,
    String? accountHolder,
  }) {
    final messages = [
      if (title != null) RegularDueValidation.title(title),
      if (bankName != null) SettlementInputValidation.bankName(bankName),
      if (accountNumber != null)
        SettlementInputValidation.accountNumber(accountNumber),
      if (accountHolder != null)
        SettlementInputValidation.accountHolder(accountHolder),
    ];
    final message = messages.whereType<String>().firstOrNull;
    if (message != null) {
      throw ApiException(code: ApiErrorCode.validation, message: message);
    }
    if (amount != null) {
      final error = RegularDueValidation.amount('$amount');
      if (error != null) fail(error);
    }
    if (dueDays != null) {
      final error = RegularDueValidation.dueDays('$dueDays');
      if (error != null) fail(error);
    }
    if (sendTime != null &&
        !RegExp(r'^([01][0-9]|2[0-3]):[0-5][0-9]$').hasMatch(sendTime)) {
      fail('발송 시간을 확인해 주세요.');
    }
    if (cycle == DuesCycle.unknown) fail('반복 주기를 다시 선택해 주세요.');
    const weekly = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    final monthly =
        cycleDay == 'LAST' ||
        (int.tryParse(cycleDay ?? '') ?? 0) >= 1 &&
            (int.tryParse(cycleDay ?? '') ?? 99) <= 28;
    if (cycle != null && cycleDay == null) fail('반복 주기를 바꾸면 청구일도 선택해 주세요.');
    if (cycleDay != null &&
        ((cycle == DuesCycle.weekly && !weekly.contains(cycleDay)) ||
            (cycle == DuesCycle.monthly && !monthly) ||
            (cycle == null && !weekly.contains(cycleDay) && !monthly))) {
      fail('청구일을 다시 선택해 주세요.');
    }
  }

  static Never fail(String message) =>
      throw ApiException(code: ApiErrorCode.validation, message: message);
}
