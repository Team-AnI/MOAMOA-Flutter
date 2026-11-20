import 'package:dio/dio.dart';

import '../../../../core/errors/api_error_code.dart';
import '../../../../core/errors/api_exception.dart';
import '../../../../core/errors/dio_exception_mapper.dart';
import '../../domain/entities/regular_due_update.dart';
import '../../domain/entities/settlement.dart';
import '../../domain/repositories/settlement_repository.dart';
import '../datasources/settlement_remote_data_source.dart';
import '../models/payment_action_model.dart';
import '../models/regular_due_create_request.dart';
import '../models/regular_due_delete_request.dart';
import '../models/regular_due_model.dart';
import '../models/regular_due_update_request.dart';
import '../models/regular_dues_list_request.dart';
import '../models/settlement_create_request.dart';
import '../models/settlement_detail_api_request.dart';
import '../models/settlement_detail_model.dart';
import '../models/settlement_list_request.dart';
import '../models/settlement_model.dart';
import '../models/settlement_payment_request.dart';
import '../models/settlement_response_model.dart';

class SettlementRepositoryImpl implements SettlementRepository {
  const SettlementRepositoryImpl({
    required SettlementRemoteDataSource settlementRemoteDataSource,
  }) : _settlementRemoteDataSource = settlementRemoteDataSource;

  final SettlementRemoteDataSource _settlementRemoteDataSource;

  T _data<T>(SettlementResponseModel<T> response) {
    final data = response.data;
    if (!response.success || data == null) {
      throw const ApiException(code: ApiErrorCode.unknown);
    }
    return data;
  }

  Future<T> _read<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw error.toApiException();
    } on FormatException {
      throw const ApiException(code: ApiErrorCode.unknown);
    } on TypeError {
      throw const ApiException(code: ApiErrorCode.unknown);
    }
  }

  @override
  Future<int> create(CreateSettlementInput input) => _read(() async {
    final data = await _settlementRemoteDataSource.create(
      SettlementCreateRequest(
        meetingId: input.meetingId,
        scheduleId: input.scheduleId,
        title: input.title,
        totalAmount: input.totalAmount,
        memberIds: input.memberIds,
        bankName: input.bankName,
        accountNumber: input.accountNumber,
        accountHolder: input.accountHolder,
        dueAt: input.dueAt.toUtc(),
        postNotice: input.postNotice,
        replacesSettlementId: input.replacesSettlementId,
      ),
    );
    return _data(data).settlementId;
  });

  @override
  Future<List<Settlement>> list(int meetingId) => _read(() async {
    final data = _data(
      await _settlementRemoteDataSource.list(
        SettlementListRequest(meetingId: meetingId),
      ),
    );
    return data.settlements
        .map((model) => model.toEntity())
        .toList(growable: false);
  });

  @override
  Future<SettlementDetail> detail(int meetingId, int settlementId) => _read(
    () async => _data(
      await _settlementRemoteDataSource.detail(
        SettlementDetailApiRequest(
          meetingId: meetingId,
          settlementId: settlementId,
        ),
      ),
    ).toEntity(),
  );

  @override
  Future<PaymentAction> submitPayment(int meetingId, int settlementId) => _read(
    () async => _data(
      await _settlementRemoteDataSource.submitPayment(
        SettlementPaymentRequest(
          meetingId: meetingId,
          settlementId: settlementId,
        ),
      ),
    ).toEntity(),
  );

  @override
  Future<PaymentAction> approvePayment(
    int meetingId,
    int settlementId,
    int paymentId,
  ) => _read(
    () async => _data(
      await _settlementRemoteDataSource.approvePayment(
        SettlementPaymentRequest(
          meetingId: meetingId,
          settlementId: settlementId,
          paymentId: paymentId,
        ),
      ),
    ).toEntity(),
  );

  @override
  Future<PaymentAction> rejectPayment(
    int meetingId,
    int settlementId,
    int paymentId, {
    String? reason,
  }) => _read(
    () async => _data(
      await _settlementRemoteDataSource.rejectPayment(
        SettlementPaymentRequest(
          meetingId: meetingId,
          settlementId: settlementId,
          paymentId: paymentId,
          reason: reason,
        ),
      ),
    ).toEntity(),
  );

  @override
  Future<List<RegularDue>> listRegularDues(int meetingId) => _read(() async {
    final response = _data(
      await _settlementRemoteDataSource.listRegularDues(
        RegularDuesListRequest(meetingId: meetingId),
      ),
    );
    return response.regularDues
        .map((model) => model.toEntity())
        .toList(growable: false);
  });
  @override
  Future<int> createRegularDue(int meetingId, RegularDueInput input) => _read(
    () async => _data(
      await _settlementRemoteDataSource.createRegularDue(
        RegularDueCreateRequest(
          meetingId: meetingId,
          title: input.title,
          amount: input.amount,
          cycleType: input.cycle.serverValue,
          cycleDay: input.cycleDay,
          sendTime: input.sendTime,
          dueDays: input.dueDays,
          bankName: input.bankName,
          accountNumber: input.accountNumber,
          accountHolder: input.accountHolder,
          postNotice: input.postNotice,
        ),
      ),
    ).regularDuesId,
  );
  @override
  Future<bool?> updateRegularDue(
    int meetingId,
    int regularDuesId,
    RegularDueUpdate changes,
  ) => _read(
    () async => _data(
      await _settlementRemoteDataSource.updateRegularDue(
        RegularDueUpdateRequest(
          meetingId: meetingId,
          regularDuesId: regularDuesId,
          title: changes.title,
          amount: changes.amount,
          cycleType: changes.cycle?.serverValue,
          cycleDay: changes.cycleDay,
          sendTime: changes.sendTime,
          dueDays: changes.dueDays,
          bankName: changes.bankName,
          accountNumber: changes.accountNumber,
          accountHolder: changes.accountHolder,
          isActive: changes.isActive,
          postNotice: changes.postNotice,
          applyToCurrentSettlement: changes.applyToCurrentSettlement
              ? true
              : null,
        ),
      ),
    ).currentSettlementApplied,
  );
  @override
  Future<void> deleteRegularDue(int meetingId, int regularDuesId) =>
      _read(() async {
        _data(
          await _settlementRemoteDataSource.deleteRegularDue(
            RegularDueDeleteRequest(
              meetingId: meetingId,
              regularDuesId: regularDuesId,
            ),
          ),
        );
      });
}
