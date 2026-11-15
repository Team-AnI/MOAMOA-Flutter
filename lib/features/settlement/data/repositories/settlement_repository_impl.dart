import 'package:dio/dio.dart';

import '../../../../core/errors/api_error_code.dart';
import '../../../../core/errors/api_exception.dart';
import '../../../../core/errors/dio_exception_mapper.dart';
import '../../domain/entities/settlement.dart';
import '../../domain/repositories/settlement_repository.dart';
import '../datasources/settlement_remote_data_source.dart';

class SettlementRepositoryImpl implements SettlementRepository {
  const SettlementRepositoryImpl({required SettlementRemoteDataSource remote})
    : _remote = remote;

  final SettlementRemoteDataSource _remote;

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
    final data = await _remote.create(input.meetingId, {
      if (input.scheduleId != null) 'scheduleId': input.scheduleId,
      'title': input.title,
      'totalAmount': input.totalAmount,
      'memberIds': input.memberIds,
      'bankName': input.bankName,
      'accountNumber': input.accountNumber,
      'accountHolder': input.accountHolder,
      'dueAt': input.dueAt.toUtc().toIso8601String(),
      'postNotice': input.postNotice,
      if (input.replacesSettlementId != null)
        'replacesSettlementId': input.replacesSettlementId,
    });
    return data['settlementId'] as int;
  });

  @override
  Future<List<Settlement>> list(int meetingId) => _read(() async {
    final data = await _remote.list(meetingId);
    return (data['settlements'] as List)
        .map((item) => _settlement(item as Map<String, dynamic>))
        .toList(growable: false);
  });

  @override
  Future<SettlementDetail> detail(int meetingId, int settlementId) =>
      _read(() async => _detail(await _remote.detail(meetingId, settlementId)));

  @override
  Future<PaymentAction> submitPayment(int meetingId, int settlementId) => _read(
    () async => _action(await _remote.submitPayment(meetingId, settlementId)),
  );

  @override
  Future<PaymentAction> approvePayment(
    int meetingId,
    int settlementId,
    int paymentId,
  ) => _read(
    () async => _action(
      await _remote.approvePayment(meetingId, settlementId, paymentId),
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
      await _remote.rejectPayment(
        meetingId,
        settlementId,
        paymentId,
        reason: reason,
      ),
    ),
  );

  @override
  Future<List<RegularDue>> listRegularDues(int meetingId) => _read(() async {
    final data = await _remote.listRegularDues(meetingId);
    return (data['regularDues'] as List)
        .map((item) => _regularDue(item as Map<String, dynamic>))
        .toList(growable: false);
  });

  @override
  Future<int> createRegularDue(int meetingId, RegularDueInput input) =>
      _read(() async {
        final data = await _remote.createRegularDue(
          meetingId,
          _regularDueBody(input),
        );
        return data['regularDuesId'] as int;
      });

  @override
  Future<bool?> updateRegularDue(
    int meetingId,
    int regularDuesId,
    RegularDueInput input, {
    required RegularDue previous,
    bool applyToCurrentSettlement = false,
  }) => _read(() async {
    final data = await _remote.updateRegularDue(meetingId, regularDuesId, {
      if (input.title != previous.title) 'title': input.title,
      if (input.amount != previous.amount) 'amount': input.amount,
      if (input.cycle != previous.cycle)
        'cycleType': switch (input.cycle) {
          DuesCycle.weekly => 'WEEKLY',
          DuesCycle.monthly => 'MONTHLY',
          DuesCycle.unknown => throw const FormatException('알 수 없는 회비 주기'),
        },
      if (input.cycle != previous.cycle || input.cycleDay != previous.cycleDay)
        'cycleDay': input.cycleDay,
      if (input.sendTime != previous.sendTime) 'sendTime': input.sendTime,
      if (input.dueDays != previous.dueDays) 'dueDays': input.dueDays,
      if (input.bankName != previous.bankName) 'bankName': input.bankName,
      if (input.accountNumber != previous.accountNumber)
        'accountNumber': input.accountNumber,
      if (input.accountHolder != previous.accountHolder)
        'accountHolder': input.accountHolder,
      if (input.postNotice != previous.postNotice)
        'postNotice': input.postNotice,
      if (input.isActive != previous.isActive) 'isActive': input.isActive,
      if (applyToCurrentSettlement) 'applyToCurrentSettlement': true,
    });
    return data['currentSettlementApplied'] as bool?;
  });

  @override
  Future<void> deleteRegularDue(int meetingId, int regularDuesId) =>
      _read(() async {
        await _remote.deleteRegularDue(meetingId, regularDuesId);
      });

  Map<String, Object?> _regularDueBody(RegularDueInput input) => {
    'title': input.title,
    'amount': input.amount,
    'cycleType': switch (input.cycle) {
      DuesCycle.weekly => 'WEEKLY',
      DuesCycle.monthly => 'MONTHLY',
      DuesCycle.unknown => throw const FormatException('알 수 없는 회비 주기'),
    },
    'cycleDay': input.cycleDay,
    'sendTime': input.sendTime,
    'dueDays': input.dueDays,
    'bankName': input.bankName,
    'accountNumber': input.accountNumber,
    'accountHolder': input.accountHolder,
    'postNotice': input.postNotice,
  };

  RegularDue _regularDue(Map<String, dynamic> json) => RegularDue(
    id: json['regularDuesId'] as int,
    title: json['title'] as String,
    amount: json['amount'] as int,
    cycle: switch (json['cycleType']) {
      'WEEKLY' => DuesCycle.weekly,
      'MONTHLY' => DuesCycle.monthly,
      _ => DuesCycle.unknown,
    },
    cycleDay: json['cycleDay'] as String,
    sendTime: json['sendTime'] as String,
    dueDays: json['dueDays'] as int,
    bankName: json['bankName'] as String,
    accountNumber: json['accountNumber'] as String,
    accountHolder: json['accountHolder'] as String,
    isActive: json['isActive'] as bool,
    postNotice: json['postNotice'] as bool,
  );

  Settlement _settlement(Map<String, dynamic> json) => Settlement(
    id: json['settlementId'] as int,
    title: json['title'] as String,
    scheduleId: json['scheduleId'] as int?,
    totalAmount: json['totalAmount'] as int,
    memberCount: json['memberCount'] as int,
    dueAt: DateTime.parse(json['dueAt'] as String),
    createdAt: DateTime.parse(json['createdAt'] as String),
    status: _settlementStatus(json['status']),
    canceledAt: _date(json['canceledAt']),
    myAmount: json['myAmount'] as int?,
    myPaymentStatus: json['myPaymentStatus'] == null
        ? null
        : _paymentStatus(json['myPaymentStatus']),
    myConfirmedAt: _date(json['myConfirmedAt']),
  );

  SettlementDetail _detail(Map<String, dynamic> json) {
    final summary = json['summary'] as Map<String, dynamic>;
    return SettlementDetail(
      id: json['settlementId'] as int,
      title: json['title'] as String,
      scheduleId: json['scheduleId'] as int?,
      scheduleTitle: json['scheduleTitle'] as String?,
      scheduleStartAt: _date(json['scheduleStartAt']),
      totalAmount: json['totalAmount'] as int,
      bankName: json['bankName'] as String,
      accountNumber: json['accountNumber'] as String,
      accountHolder: json['accountHolder'] as String,
      dueAt: DateTime.parse(json['dueAt'] as String),
      status: _settlementStatus(json['status']),
      noticeId: json['noticeId'] as int?,
      canceledAt: _date(json['canceledAt']),
      cancelReason: json['cancelReason'] as String?,
      replacesSettlementId: json['replacesSettlementId'] as int?,
      replacedBySettlementId: json['replacedBySettlementId'] as int?,
      myPayment: json['myPayment'] == null
          ? null
          : _payment(json['myPayment'] as Map<String, dynamic>),
      summary: SettlementSummary(
        totalCount: summary['totalCount'] as int,
        unpaidCount: summary['unpaidCount'] as int,
        pendingCount: summary['pendingCount'] as int,
        paidCount: summary['paidCount'] as int,
        refundedCount: summary['refundedCount'] as int,
        paidAmount: summary['paidAmount'] as int,
      ),
      payments: (json['payments'] as List? ?? const [])
          .map((item) => _payment(item as Map<String, dynamic>))
          .toList(growable: false),
    );
  }

  SettlementPayment _payment(Map<String, dynamic> json) => SettlementPayment(
    id: json['paymentId'] as int,
    amount: json['amount'] as int,
    status: _paymentStatus(json['status']),
    memberId: json['memberId'] as int?,
    userName: json['userName'] as String?,
    submittedAt: _date(json['submittedAt']),
    refundedAt: _date(json['refundedAt']),
  );

  PaymentAction _action(Map<String, dynamic> json) => PaymentAction(
    paymentId: json['paymentId'] as int,
    status: _paymentStatus(json['status']),
    submittedAt: _date(json['submittedAt']),
    confirmedAt: _date(json['confirmedAt']),
    rejectionReason: json['rejectionReason'] as String?,
  );

  DateTime? _date(Object? value) =>
      value is String ? DateTime.parse(value) : null;

  SettlementStatus _settlementStatus(Object? value) => switch (value) {
    'IN_PROGRESS' => SettlementStatus.inProgress,
    'COMPLETED' => SettlementStatus.completed,
    'CANCELED' => SettlementStatus.canceled,
    _ => SettlementStatus.unknown,
  };

  PaymentStatus _paymentStatus(Object? value) => switch (value) {
    'UNPAID' => PaymentStatus.unpaid,
    'PENDING' => PaymentStatus.pending,
    'PAID' => PaymentStatus.paid,
    'REFUNDED' => PaymentStatus.refunded,
    _ => PaymentStatus.unknown,
  };
}
