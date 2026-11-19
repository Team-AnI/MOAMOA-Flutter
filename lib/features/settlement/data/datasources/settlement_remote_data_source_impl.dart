import 'package:dio/dio.dart';

import '../models/settlement_create_request.dart';
import '../models/settlement_create_model.dart';
import '../models/settlement_list_model.dart';
import '../models/settlement_detail_model.dart';
import '../models/settlement_payment_request.dart';
import '../models/payment_action_model.dart';
import 'settlement_remote_data_source.dart';

class SettlementRemoteDataSourceImpl implements SettlementRemoteDataSource {
  const SettlementRemoteDataSourceImpl({
    required Dio dio,
    required String baseUrl,
  }) : _dio = dio,
       _baseUrl = baseUrl;
  final Dio _dio;
  final String _baseUrl;

  @override
  Future<SettlementCreateModel> create(SettlementCreateRequest request) async =>
      SettlementCreateModel.fromJson(
        await _request(
          'POST',
          '/v1/meetings/${request.meetingId}/settlements',
          body: request.toJson(),
        ),
      );
  @override
  Future<SettlementListModel> list(int meetingId) async =>
      SettlementListModel.fromJson(
        await _request('GET', '/v1/meetings/$meetingId/settlements'),
      );
  @override
  Future<SettlementDetailModel> detail(int meetingId, int settlementId) async =>
      SettlementDetailModel.fromJson(
        await _request(
          'GET',
          '/v1/meetings/$meetingId/settlements/$settlementId',
        ),
      );
  @override
  Future<PaymentActionModel> submitPayment(
    SettlementPaymentRequest request,
  ) async => PaymentActionModel.fromJson(
    await _request(
      'POST',
      '/v1/meetings/${request.meetingId}/settlements/${request.settlementId}/payments/me/submissions',
    ),
  );
  @override
  Future<PaymentActionModel> approvePayment(
    SettlementPaymentRequest request,
  ) async => PaymentActionModel.fromJson(
    await _request(
      'POST',
      '/v1/meetings/${request.meetingId}/settlements/${request.settlementId}/payments/${request.paymentId}/approval',
    ),
  );
  @override
  Future<PaymentActionModel> rejectPayment(
    SettlementPaymentRequest request,
  ) async => PaymentActionModel.fromJson(
    await _request(
      'POST',
      '/v1/meetings/${request.meetingId}/settlements/${request.settlementId}/payments/${request.paymentId}/rejection',
      body: request.toJson(),
    ),
  );

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final base = _baseUrl.endsWith('/') ? _baseUrl : '$_baseUrl/';
    final target = _baseUrl.isEmpty
        ? path
        : Uri.parse(base).resolve(path.substring(1)).toString();
    final response = await _dio.request<Object?>(
      target,
      data: body,
      options: Options(method: method, contentType: Headers.jsonContentType),
    );
    final envelope = response.data;
    if (envelope is! Map || envelope['success'] != true) {
      throw const FormatException('잘못된 정산 API 응답');
    }
    final data = envelope['data'];
    if (data is! Map<String, dynamic>) {
      throw const FormatException('정산 응답 데이터가 없습니다');
    }
    return data;
  }
}
