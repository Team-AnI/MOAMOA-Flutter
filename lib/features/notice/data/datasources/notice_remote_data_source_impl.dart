import 'package:dio/dio.dart';

import '../models/create_notice_request.dart';
import '../models/delete_notice_request.dart';
import '../models/fetch_my_role_request.dart';
import '../models/fetch_notice_detail_request.dart';
import '../models/fetch_notices_request.dart';
import '../models/notice_list_model.dart';
import '../models/notice_model.dart';
import '../models/pin_notice_request.dart';
import '../models/unpin_notice_request.dart';
import '../models/update_notice_request.dart';
import 'notice_remote_data_source.dart';

/// 공지 API 를 Dio 로 호출합니다.
///
/// 실패 응답은 Dio 가 던지는 DioException 을 그대로 Repository 로 전달합니다.
class NoticeRemoteDataSourceImpl implements NoticeRemoteDataSource {
  const NoticeRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<NoticeListModel> fetchNotices(FetchNoticesRequest request) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}/notices',
      queryParameters: request.toJson(),
    );
    return NoticeListModel.fromJson(_data(response));
  }

  @override
  Future<NoticeModel> fetchNoticeDetail(
    FetchNoticeDetailRequest request,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}/notices/${request.noticeId}',
    );
    return NoticeModel.fromJson(_data(response));
  }

  @override
  Future<int> createNotice(CreateNoticeRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}/notices',
      data: request.toJson(),
    );
    return _data(response)['noticeId'] as int;
  }

  @override
  Future<void> updateNotice(UpdateNoticeRequest request) async {
    await _dio.patch<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}/notices/${request.noticeId}',
      data: request.toJson(),
    );
  }

  @override
  Future<void> deleteNotice(DeleteNoticeRequest request) async {
    await _dio.delete<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}/notices/${request.noticeId}',
    );
  }

  @override
  Future<String> fetchMyRole(FetchMyRoleRequest request) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}',
    );
    return _data(response)['myRole'] as String;
  }

  @override
  Future<void> pinNotice(PinNoticeRequest request) async {
    await _dio.post<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}/notices/${request.noticeId}/pin',
    );
  }

  @override
  Future<void> unpinNotice(UnpinNoticeRequest request) async {
    await _dio.delete<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}/notices/${request.noticeId}/pin',
    );
  }

  /// 공통 응답 { success, data, error, timestamp } 에서 data 를 꺼냅니다.
  ///
  /// 응답 형식이 다르면 크래시 대신 DioException 을 던져 Repository 에서 처리되게 합니다.
  Map<String, dynamic> _data(Response<Map<String, dynamic>> response) {
    final data = response.data?['data'];
    if (data is! Map<String, dynamic>) {
      throw DioException.badResponse(
        statusCode: response.statusCode ?? 200,
        requestOptions: response.requestOptions,
        response: response,
      );
    }
    return data;
  }
}
