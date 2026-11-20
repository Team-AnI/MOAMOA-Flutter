import 'package:dio/dio.dart';

import '../models/payment_action_model.dart';
import '../models/regular_due_create_model.dart';
import '../models/regular_due_create_request.dart';
import '../models/regular_due_delete_model.dart';
import '../models/regular_due_delete_request.dart';
import '../models/regular_due_update_model.dart';
import '../models/regular_due_update_request.dart';
import '../models/regular_dues_list_model.dart';
import '../models/regular_dues_list_request.dart';
import '../models/settlement_create_model.dart';
import '../models/settlement_create_request.dart';
import '../models/settlement_detail_api_request.dart';
import '../models/settlement_detail_model.dart';
import '../models/settlement_list_model.dart';
import '../models/settlement_list_request.dart';
import '../models/settlement_payment_request.dart';
import '../models/settlement_response_model.dart';
import 'settlement_remote_data_source.dart';

class SettlementRemoteDataSourceImpl implements SettlementRemoteDataSource {
  const SettlementRemoteDataSourceImpl({required Dio dio}) : _dio = dio;
  final Dio _dio;

  @override
  Future<SettlementResponseModel<SettlementCreateModel>> create(
    SettlementCreateRequest request,
  ) => _request(
    'POST',
    '/v1/meetings/${request.meetingId}/settlements',
    SettlementCreateModel.fromJson,
    body: request.toJson(),
  );
  @override
  Future<SettlementResponseModel<SettlementListModel>> list(
    SettlementListRequest request,
  ) => _request(
    'GET',
    '/v1/meetings/${request.meetingId}/settlements',
    SettlementListModel.fromJson,
  );
  @override
  Future<SettlementResponseModel<SettlementDetailModel>> detail(
    SettlementDetailApiRequest request,
  ) => _request(
    'GET',
    '/v1/meetings/${request.meetingId}/settlements/${request.settlementId}',
    SettlementDetailModel.fromJson,
  );
  @override
  Future<SettlementResponseModel<PaymentActionModel>> submitPayment(
    SettlementPaymentRequest request,
  ) => _request(
    'POST',
    '/v1/meetings/${request.meetingId}/settlements/${request.settlementId}/payments/me/submissions',
    PaymentActionModel.fromJson,
  );
  @override
  Future<SettlementResponseModel<PaymentActionModel>> approvePayment(
    SettlementPaymentRequest request,
  ) => _request(
    'POST',
    '/v1/meetings/${request.meetingId}/settlements/${request.settlementId}/payments/${request.paymentId}/approval',
    PaymentActionModel.fromJson,
  );
  @override
  Future<SettlementResponseModel<PaymentActionModel>> rejectPayment(
    SettlementPaymentRequest request,
  ) => _request(
    'POST',
    '/v1/meetings/${request.meetingId}/settlements/${request.settlementId}/payments/${request.paymentId}/rejection',
    PaymentActionModel.fromJson,
    body: request.toJson(),
  );

  @override
  Future<SettlementResponseModel<RegularDuesListModel>> listRegularDues(
    RegularDuesListRequest request,
  ) => _request(
    'GET',
    '/v1/meetings/${request.meetingId}/regular-dues',
    RegularDuesListModel.fromJson,
  );
  @override
  Future<SettlementResponseModel<RegularDueCreateModel>> createRegularDue(
    RegularDueCreateRequest request,
  ) => _request(
    'POST',
    '/v1/meetings/${request.meetingId}/regular-dues',
    RegularDueCreateModel.fromJson,
    body: request.toJson(),
  );
  @override
  Future<SettlementResponseModel<RegularDueUpdateModel>> updateRegularDue(
    RegularDueUpdateRequest request,
  ) => _request(
    'PATCH',
    '/v1/meetings/${request.meetingId}/regular-dues/${request.regularDuesId}',
    RegularDueUpdateModel.fromJson,
    body: request.toJson(),
  );
  @override
  Future<SettlementResponseModel<RegularDueDeleteModel>> deleteRegularDue(
    RegularDueDeleteRequest request,
  ) => _request(
    'DELETE',
    '/v1/meetings/${request.meetingId}/regular-dues/${request.regularDuesId}',
    RegularDueDeleteModel.fromJson,
  );

  Future<SettlementResponseModel<T>> _request<T>(
    String method,
    String path,
    T Function(Map<String, dynamic>) decode, {
    Map<String, dynamic>? body,
  }) async {
    final response = await _dio.request<Map<String, dynamic>>(
      path,
      data: body,
      options: Options(method: method, contentType: Headers.jsonContentType),
    );
    return SettlementResponseModel<T>.fromJson(
      response.data!,
      (json) => decode(json as Map<String, dynamic>),
    );
  }
}
