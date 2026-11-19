import 'package:dio/dio.dart';

import '../../../../core/errors/api_error_code.dart';
import '../../../../core/errors/api_exception.dart';
import '../../../../core/errors/dio_exception_mapper.dart';
import '../../domain/entities/settlement.dart';
import '../../domain/repositories/settlement_repository.dart';
import '../datasources/settlement_remote_data_source.dart';
import '../models/settlement_model.dart';
import '../models/settlement_payment_model.dart';
import '../models/settlement_detail_model.dart';
import '../models/payment_action_model.dart';
import '../models/settlement_create_request.dart';
import '../models/settlement_payment_request.dart';

class SettlementRepositoryImpl implements SettlementRepository {
  const SettlementRepositoryImpl({
    required SettlementRemoteDataSource settlementRemoteDataSource,
  }) : _settlementRemoteDataSource = settlementRemoteDataSource;

  final SettlementRemoteDataSource _settlementRemoteDataSource;

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
    return data.settlementId;
  });

  @override
  Future<List<Settlement>> list(int meetingId) => _read(() async {
    final data = await _settlementRemoteDataSource.list(meetingId);
    return data.settlements.map(_settlement).toList(growable: false);
  });

  @override
  Future<SettlementDetail> detail(int meetingId, int settlementId) => _read(
    () async => _detail(
      await _settlementRemoteDataSource.detail(meetingId, settlementId),
    ),
  );

  @override
  Future<PaymentAction> submitPayment(int meetingId, int settlementId) => _read(
    () async => _action(
      await _settlementRemoteDataSource.submitPayment(
        SettlementPaymentRequest(
          meetingId: meetingId,
          settlementId: settlementId,
        ),
      ),
    ),
  );

  @override
  Future<PaymentAction> approvePayment(
    int meetingId,
    int settlementId,
    int paymentId,
  ) => _read(
    () async => _action(
      await _settlementRemoteDataSource.approvePayment(
        SettlementPaymentRequest(
          meetingId: meetingId,
          settlementId: settlementId,
          paymentId: paymentId,
        ),
      ),
    ),
  );

  @override
  Future<PaymentAction> rejectPayment(
    int meetingId,
    int settlementId,
    int paymentId, {
    String? reason,
  }) => _read(
    () async => _action(
      await _settlementRemoteDataSource.rejectPayment(
        SettlementPaymentRequest(
          meetingId: meetingId,
          settlementId: settlementId,
          paymentId: paymentId,
          reason: reason,
        ),
      ),
    ),
  );

  Settlement _settlement(SettlementModel json) => Settlement(
    id: json.settlementId,
    title: json.title,
    scheduleId: json.scheduleId,
    totalAmount: json.totalAmount,
    memberCount: json.memberCount,
    dueAt: json.dueAt,
    createdAt: json.createdAt,
    status: SettlementStatus.fromServer(json.status),
    canceledAt: json.canceledAt,
    myAmount: json.myAmount,
    myPaymentStatus: json.myPaymentStatus == null
        ? null
        : PaymentStatus.fromServer(json.myPaymentStatus),
    myConfirmedAt: json.myConfirmedAt,
  );

  SettlementDetail _detail(SettlementDetailModel json) {
    final summary = json.summary;
    return SettlementDetail(
      id: json.settlementId,
      title: json.title,
      scheduleId: json.scheduleId,
      scheduleTitle: json.scheduleTitle,
      scheduleStartAt: json.scheduleStartAt,
      totalAmount: json.totalAmount,
      bankName: json.bankName,
      accountNumber: json.accountNumber,
      accountHolder: json.accountHolder,
      dueAt: json.dueAt,
      status: SettlementStatus.fromServer(json.status),
      noticeId: json.noticeId,
      canceledAt: json.canceledAt,
      cancelReason: json.cancelReason,
      replacesSettlementId: json.replacesSettlementId,
      replacedBySettlementId: json.replacedBySettlementId,
      myPayment: json.myPayment == null ? null : _payment(json.myPayment!),
      summary: SettlementSummary(
        totalCount: summary.totalCount,
        unpaidCount: summary.unpaidCount,
        pendingCount: summary.pendingCount,
        paidCount: summary.paidCount,
        refundedCount: summary.refundedCount,
        paidAmount: summary.paidAmount,
      ),
      payments: json.payments.map(_payment).toList(growable: false),
    );
  }

  SettlementPayment _payment(SettlementPaymentModel json) => SettlementPayment(
    id: json.paymentId,
    amount: json.amount,
    status: PaymentStatus.fromServer(json.status),
    memberId: json.memberId,
    userName: json.userName,
    submittedAt: json.submittedAt,
    refundedAt: json.refundedAt,
  );

  PaymentAction _action(PaymentActionModel json) => PaymentAction(
    paymentId: json.paymentId,
    status: PaymentStatus.fromServer(json.status),
    submittedAt: json.submittedAt,
    confirmedAt: json.confirmedAt,
    rejectionReason: json.rejectionReason,
  );
}
