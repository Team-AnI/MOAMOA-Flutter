import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_settlement_input.freezed.dart';

@freezed
abstract class CreateSettlementInput with _$CreateSettlementInput {
  const factory CreateSettlementInput({
    required int meetingId,
    int? scheduleId,
    required String title,
    required int totalAmount,
    required List<int> memberIds,
    required String bankName,
    required String accountNumber,
    required String accountHolder,
    required DateTime dueAt,
    @Default(false) bool postNotice,
    int? replacesSettlementId,
  }) = _CreateSettlementInput;
}
