import '../../domain/entities/notice_account.dart';

/// 공지에 함께 오는 관리자 계좌 (API 명세에 아직 없는 가정 필드)
class NoticeAccountModel {
  const NoticeAccountModel({
    required this.bankName,
    required this.accountNumber,
    required this.holderName,
  });

  factory NoticeAccountModel.fromJson(Map<String, dynamic> json) {
    return NoticeAccountModel(
      bankName: json['bankName'] as String,
      accountNumber: json['accountNumber'] as String,
      holderName: json['holderName'] as String,
    );
  }

  final String bankName;
  final String accountNumber;
  final String holderName;

  NoticeAccount toEntity() => NoticeAccount(
    bankName: bankName,
    accountNumber: accountNumber,
    holderName: holderName,
  );
}
