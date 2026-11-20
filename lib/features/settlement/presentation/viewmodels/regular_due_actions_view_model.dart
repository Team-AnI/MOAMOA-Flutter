import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/api_error_code.dart';
import '../../../../core/errors/api_exception.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../domain/entities/current_settlement_application.dart';
import '../../domain/entities/regular_due_update.dart';
import '../../domain/entities/settlement.dart';
import '../../domain/usecases/create_regular_due.dart';
import '../../domain/usecases/delete_regular_due.dart';
import '../../domain/usecases/update_regular_due.dart';
import '../providers/settlement_providers.dart';
import 'regular_due_action.dart';
import 'regular_due_action_state.dart';

class RegularDueActionsViewModel extends Notifier<RegularDueActionState> {
  RegularDueActionsViewModel({required this.meetingId});
  final int meetingId;
  @override
  RegularDueActionState build() => const RegularDueActionState();
  Future<void> create(RegularDueInput input) =>
      _run(RegularDueAction.create, () async {
        await ref.read(createRegularDueProvider)(
          CreateRegularDueParams(meetingId: meetingId, input: input),
        );
        return CurrentSettlementApplication.notRequested;
      });
  Future<void> update(int id, RegularDueUpdate changes) => _run(
    RegularDueAction.update,
    () => ref.read(updateRegularDueProvider)(
      UpdateRegularDueParams(
        meetingId: meetingId,
        regularDuesId: id,
        changes: changes,
      ),
    ),
    refreshSettlements: changes.applyToCurrentSettlement,
  );
  Future<void> delete(int id) => _run(RegularDueAction.delete, () async {
    await ref.read(deleteRegularDueProvider)(
      DeleteRegularDueParams(meetingId: meetingId, regularDuesId: id),
    );
    return CurrentSettlementApplication.notRequested;
  });

  void _refresh(bool settlements) {
    ref.invalidate(regularDuesProvider(meetingId));
    if (settlements) {
      // 조회 키를 별도로 추적하지 않습니다. 살아 있는 상세 구독은 다시 조회됩니다.
      ref.invalidate(settlementDetailProvider);
      ref.invalidate(settlementListProvider(meetingId));
    }
  }

  Future<void> _run(
    RegularDueAction action,
    Future<CurrentSettlementApplication> Function() request, {
    bool refreshSettlements = false,
  }) async {
    if (state.isSubmitting) return;
    final link = ref.keepAlive();
    state = RegularDueActionState(isSubmitting: true, action: action);
    try {
      final result = await request();
      if (!ref.mounted) return;
      _refresh(refreshSettlements);
      state = RegularDueActionState(action: action, application: result);
    } on ApiException catch (error) {
      if (!ref.mounted) return;
      if ({
        ApiErrorCode.conflict,
        ApiErrorCode.unprocessableEntity,
        ApiErrorCode.forbidden,
      }.contains(error.code)) {
        _refresh(refreshSettlements);
        if (error.code == ApiErrorCode.forbidden) {
          ref.invalidate(groupMyRoleProvider(meetingId));
        }
      }
      state = RegularDueActionState(action: action, failure: error);
    } catch (_) {
      if (ref.mounted) {
        state = RegularDueActionState(
          action: action,
          failure: const ApiException(code: ApiErrorCode.unknown),
        );
      }
    } finally {
      link.close();
    }
  }
}
