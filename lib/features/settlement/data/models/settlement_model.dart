import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/settlement.dart';

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

extension SettlementModelX on SettlementModel {
  Settlement toEntity() => Settlement(
    id: settlementId,
    title: title,
    scheduleId: scheduleId,
    totalAmount: totalAmount,
    memberCount: memberCount,
    dueAt: dueAt,
    createdAt: createdAt,
    status: SettlementStatus.fromServer(status),
    canceledAt: canceledAt,
    myAmount: myAmount,
    myPaymentStatus: myPaymentStatus == null
        ? null
        : PaymentStatus.fromServer(myPaymentStatus),
    myConfirmedAt: myConfirmedAt,
  );
}
