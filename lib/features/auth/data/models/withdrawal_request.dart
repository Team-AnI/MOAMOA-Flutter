import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdrawal_request.freezed.dart';
part 'withdrawal_request.g.dart';

/// 회원 탈퇴(7-9). [toJson] 은 요청 본문(password)이 됩니다.
@freezed
abstract class WithdrawalRequest with _$WithdrawalRequest {
  const factory WithdrawalRequest({required String password}) =
      _WithdrawalRequest;

  factory WithdrawalRequest.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalRequestFromJson(json);
}
