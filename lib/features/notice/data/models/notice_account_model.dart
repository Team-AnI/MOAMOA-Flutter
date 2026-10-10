import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notice_account.dart';

part 'notice_account_model.freezed.dart';
part 'notice_account_model.g.dart';

/// 공지에 함께 오는 관리자 계좌 (API 명세에 아직 없는 가정 필드)
@freezed
abstract class NoticeAccountModel with _$NoticeAccountModel {
  const NoticeAccountModel._();

  const factory NoticeAccountModel({
    required String bankName,
    required String accountNumber,
    required String holderName,
  }) = _NoticeAccountModel;

  factory NoticeAccountModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeAccountModelFromJson(json);

  NoticeAccount toEntity() => NoticeAccount(
    bankName: bankName,
    accountNumber: accountNumber,
    holderName: holderName,
  );
}
