/// 공지에 함께 보여주는 관리자 계좌 (회비 정산 안내 등)
class NoticeAccount {
  const NoticeAccount({
    required this.bankName,
    required this.accountNumber,
    required this.holderName,
  });

  final String bankName;
  final String accountNumber;
  final String holderName;
}
