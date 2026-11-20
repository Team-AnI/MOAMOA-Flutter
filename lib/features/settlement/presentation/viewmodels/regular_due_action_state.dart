import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/errors/api_exception.dart';
import '../../domain/entities/current_settlement_application.dart';
import '../regular_due_application_message.dart';
import 'regular_due_action.dart';

part 'regular_due_action_state.freezed.dart';

@freezed
abstract class RegularDueActionState with _$RegularDueActionState {
  const factory RegularDueActionState({
    @Default(false) bool isSubmitting,
    RegularDueAction? action,
    @Default(CurrentSettlementApplication.notRequested)
    CurrentSettlementApplication application,
    ApiException? failure,
  }) = _RegularDueActionState;
}

extension RegularDueActionStateX on RegularDueActionState {
  String get message =>
      action == RegularDueAction.delete ? '정기 회비를 삭제했어요.' : application.message;
}
