import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/settlement_remote_data_source.dart';
import '../../data/datasources/settlement_remote_data_source_impl.dart';
import '../../data/repositories/settlement_repository_impl.dart';
import '../../domain/entities/settlement.dart';
import '../../domain/repositories/settlement_repository.dart';
import '../../domain/usecases/approve_payment.dart';
import '../../domain/usecases/create_regular_due.dart';
import '../../domain/usecases/create_settlement.dart';
import '../../domain/usecases/delete_regular_due.dart';
import '../../domain/usecases/get_regular_dues.dart';
import '../../domain/usecases/get_settlement.dart';
import '../../domain/usecases/get_settlements.dart';
import '../../domain/usecases/reject_payment.dart';
import '../../domain/usecases/submit_payment.dart';
import '../../domain/usecases/update_regular_due.dart';
import '../settlement_detail_request.dart';
import '../viewmodels/regular_due_action_state.dart';
import '../viewmodels/regular_due_actions_view_model.dart';
import '../viewmodels/settlement_action_state.dart';
import '../viewmodels/settlement_actions_view_model.dart';

export '../settlement_detail_request.dart';

final settlementRemoteDataSourceProvider = Provider<SettlementRemoteDataSource>(
  (ref) => SettlementRemoteDataSourceImpl(dio: ref.watch(dioProvider)),
);
final settlementRepositoryProvider = Provider<SettlementRepository>(
  (ref) => SettlementRepositoryImpl(
    settlementRemoteDataSource: ref.watch(settlementRemoteDataSourceProvider),
  ),
);
final createSettlementProvider = Provider<CreateSettlement>(
  (ref) => CreateSettlementImpl(
    settlementRepository: ref.watch(settlementRepositoryProvider),
  ),
);
final getSettlementsProvider = Provider<GetSettlements>(
  (ref) => GetSettlementsImpl(
    settlementRepository: ref.watch(settlementRepositoryProvider),
  ),
);
final getSettlementProvider = Provider<GetSettlement>(
  (ref) => GetSettlementImpl(
    settlementRepository: ref.watch(settlementRepositoryProvider),
  ),
);
final submitPaymentProvider = Provider<SubmitPayment>(
  (ref) => SubmitPaymentImpl(
    settlementRepository: ref.watch(settlementRepositoryProvider),
  ),
);
final approvePaymentProvider = Provider<ApprovePayment>(
  (ref) => ApprovePaymentImpl(
    settlementRepository: ref.watch(settlementRepositoryProvider),
  ),
);
final rejectPaymentProvider = Provider<RejectPayment>(
  (ref) => RejectPaymentImpl(
    settlementRepository: ref.watch(settlementRepositoryProvider),
  ),
);

/// 목록·상세는 서버 응답을 노출하고, 명령의 진행 상태는 별도 ViewModel이 소유합니다.
final settlementListProvider = FutureProvider.autoDispose
    .family<List<Settlement>, int>(
      (ref, meetingId) => ref.watch(getSettlementsProvider)(
        GetSettlementsParams(meetingId: meetingId),
      ),
    );
final settlementDetailProvider = FutureProvider.autoDispose
    .family<SettlementDetail, SettlementDetailRequest>(
      (ref, request) => ref.watch(getSettlementProvider)(
        GetSettlementParams(
          meetingId: request.meetingId,
          settlementId: request.settlementId,
        ),
      ),
    );
final settlementActionsProvider = NotifierProvider.autoDispose
    .family<SettlementActionsViewModel, SettlementActionState, int>(
      (meetingId) => SettlementActionsViewModel(meetingId: meetingId),
    );

final regularDuesProvider = FutureProvider.autoDispose
    .family<List<RegularDue>, int>(
      (ref, meetingId) => ref.watch(getRegularDuesProvider)(
        GetRegularDuesParams(meetingId: meetingId),
      ),
    );

final getRegularDuesProvider = Provider<GetRegularDues>(
  (ref) => GetRegularDuesImpl(
    settlementRepository: ref.watch(settlementRepositoryProvider),
  ),
);

final createRegularDueProvider = Provider<CreateRegularDue>(
  (ref) => CreateRegularDueImpl(
    settlementRepository: ref.watch(settlementRepositoryProvider),
  ),
);

final updateRegularDueProvider = Provider<UpdateRegularDue>(
  (ref) => UpdateRegularDueImpl(
    settlementRepository: ref.watch(settlementRepositoryProvider),
  ),
);

final deleteRegularDueProvider = Provider<DeleteRegularDue>(
  (ref) => DeleteRegularDueImpl(
    settlementRepository: ref.watch(settlementRepositoryProvider),
  ),
);

final regularDueActionsProvider = NotifierProvider.autoDispose
    .family<RegularDueActionsViewModel, RegularDueActionState, int>(
      (meetingId) => RegularDueActionsViewModel(meetingId: meetingId),
    );
