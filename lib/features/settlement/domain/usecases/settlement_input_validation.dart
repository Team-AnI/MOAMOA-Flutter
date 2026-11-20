/// API 명세의 입력 제약을 화면과 UseCase가 함께 사용합니다.
class SettlementInputValidation {
  static String? title(String value) => text(value, '정산 이름', 50);
  static String? bankName(String value) => text(value, '은행', 20);
  static String? accountNumber(String value) =>
      value.trim().isEmpty ? '계좌번호를 입력해 주세요.' : text(value, '계좌번호', 30);
  static String? accountHolder(String value) =>
      value.trim().isEmpty ? '예금주를 입력해 주세요.' : text(value, '예금주', 20);
  static String? text(String value, String label, int maxLength) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return '$label을 입력해 주세요.';
    if (trimmed.length > maxLength) return '$label은 $maxLength자 이하여야 해요.';
    return null;
  }

  static int? parseAmount(String value) =>
      int.tryParse(value.replaceAll(',', '').trim());
  static String? amount(String value) {
    final parsed = parseAmount(value);
    if (parsed == null || parsed < 1 || parsed > 2147483647) {
      return '1~2,147,483,647원 범위로 입력해 주세요.';
    }
    return null;
  }
}
