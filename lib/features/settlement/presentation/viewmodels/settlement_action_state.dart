import 'package:freezed_annotation/freezed_annotation.dart';
part 'settlement_action_state.freezed.dart';

@freezed
abstract class SettlementActionState with _$SettlementActionState {
  const factory SettlementActionState({@Default(false) bool isSubmitting}) =
      _SettlementActionState;
}
