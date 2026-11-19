import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/settlement.dart';
import '../../domain/entities/regular_due_update.dart';
import '../../domain/entities/current_settlement_application.dart';
import '../../domain/usecases/create_regular_due.dart';
import '../../domain/usecases/update_regular_due.dart';
import '../../domain/usecases/delete_regular_due.dart';
import '../providers/settlement_providers.dart';
import 'settlement_action_state.dart';

class RegularDueActionsViewModel extends Notifier<SettlementActionState> {
  RegularDueActionsViewModel({required this.meetingId});
  final int meetingId;
  @override
  SettlementActionState build() => const SettlementActionState();
  Future<int?> create(RegularDueInput input) => _run(
    () => ref.read(createRegularDueProvider)(
      CreateRegularDueParams(meetingId: meetingId, input: input),
    ),
  );
  Future<CurrentSettlementApplication?> update(
    int id,
    RegularDueUpdate changes,
  ) => _run(
    () => ref.read(updateRegularDueProvider)(
      UpdateRegularDueParams(
        meetingId: meetingId,
        regularDuesId: id,
        changes: changes,
      ),
    ),
    refreshSettlements: changes.applyToCurrentSettlement,
  );
  Future<bool?> delete(int id) => _run(() async {
    await ref.read(deleteRegularDueProvider)(
      DeleteRegularDueParams(meetingId: meetingId, regularDuesId: id),
    );
    return true;
  });
  Future<T?> _run<T>(
    Future<T> Function() action, {
    bool refreshSettlements = false,
  }) async {
    if (state.isSubmitting) return null;
    final link = ref.keepAlive();
    state = const SettlementActionState(isSubmitting: true);
    try {
      final result = await action();
      if (ref.mounted) {
        ref.invalidate(regularDuesProvider(meetingId));
        if (refreshSettlements) {
          final keys = ref
              .read(settlementDetailKeysProvider)
              .forMeeting(meetingId);
          for (final key in keys) {
            ref.invalidate(settlementDetailProvider(key));
          }
          ref.invalidate(settlementListProvider(meetingId));
        }
      }
      return result;
    } finally {
      if (ref.mounted) state = const SettlementActionState();
      link.close();
    }
  }
}
