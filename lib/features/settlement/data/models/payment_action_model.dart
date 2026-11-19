import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_action_model.freezed.dart';
part 'payment_action_model.g.dart';

@freezed
abstract class PaymentActionModel with _$PaymentActionModel {
  const factory PaymentActionModel({
    required int paymentId,
    required String status,
    DateTime? submittedAt,
    DateTime? confirmedAt,
    String? rejectionReason,
  }) = _PaymentActionModel;
  factory PaymentActionModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentActionModelFromJson(json);
}
