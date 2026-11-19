import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_model.freezed.dart';
part 'settlement_model.g.dart';

@freezed
abstract class SettlementModel with _$SettlementModel {
  const factory SettlementModel({
    required int settlementId,
    required String title,
    int? scheduleId,
    required int totalAmount,
    required int memberCount,
    required DateTime dueAt,
    required DateTime createdAt,
    required String status,
    DateTime? canceledAt,
    int? myAmount,
    String? myPaymentStatus,
    DateTime? myConfirmedAt,
  }) = _SettlementModel;
  factory SettlementModel.fromJson(Map<String, dynamic> json) =>
      _$SettlementModelFromJson(json);
}
