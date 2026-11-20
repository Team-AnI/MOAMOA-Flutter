import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/api_exception.dart';
import 'settlement_action.dart';

part 'settlement_action_state.freezed.dart';

@freezed
abstract class SettlementActionState with _$SettlementActionState {
  const factory SettlementActionState({
    @Default(false) bool isSubmitting,
    SettlementAction? action,
    int? settlementId,
    int? createdSettlementId,
    ApiException? failure,
  }) = _SettlementActionState;
}
