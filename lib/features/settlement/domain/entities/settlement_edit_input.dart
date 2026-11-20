import 'package:freezed_annotation/freezed_annotation.dart';

part 'settlement_edit_input.freezed.dart';

@freezed
abstract class SettlementEditInput with _$SettlementEditInput {
  const factory SettlementEditInput({
    String? title,
    int? totalAmount,
    List<int>? memberIds,
    String? bankName,
    String? accountNumber,
    String? accountHolder,
    DateTime? dueAt,
    @Default(false) bool unlinkSchedule,
  }) = _SettlementEditInput;
}
