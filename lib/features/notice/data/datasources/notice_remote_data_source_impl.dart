import 'package:dio/dio.dart';

import '../models/notice_list_model.dart';
import '../models/notice_model.dart';
import '../models/notice_request_model.dart';
import 'notice_remote_data_source.dart';

/// 공지 API 를 Dio 로 호출합니다.
///
/// 실패 응답은 Dio 가 던지는 DioException 을 그대로 Repository 로 전달합니다.
class NoticeRemoteDataSourceImpl implements NoticeRemoteDataSource {
  const NoticeRemoteDataSourceImpl({required this._dio});

  final Dio _dio;

  @override
  Future<NoticeListModel> fetchNotices({
    required int meetingId,
    required int page,
    required int size,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/v1/meetings/$meetingId/notices',
      queryParameters: {'page': page, 'size': size},
    );
    return NoticeListModel.fromJson(_data(response));
  }

  @override
  Future<NoticeModel> fetchNoticeDetail({
    required int meetingId,
    required int noticeId,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/v1/meetings/$meetingId/notices/$noticeId',
    );
    return NoticeModel.fromJson(_data(response));
  }

  @override
  Future<int> createNotice({
    required int meetingId,
    required NoticeRequestModel request,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/v1/meetings/$meetingId/notices',
      data: request.toJson(),
    );
    return _data(response)['noticeId'] as int;
  }

  @override
  Future<void> updateNotice({
    required int meetingId,
    required int noticeId,
    required NoticeRequestModel request,
  }) async {
    await _dio.patch<Map<String, dynamic>>(
      '/v1/meetings/$meetingId/notices/$noticeId',
      data: request.toJson(),
    );
  }

  @override
  Future<void> deleteNotice({
    required int meetingId,
    required int noticeId,
  }) async {
    await _dio.delete<Map<String, dynamic>>(
      '/v1/meetings/$meetingId/notices/$noticeId',
    );
  }

  @override
  Future<String> fetchMyRole({required int meetingId}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/v1/meetings/$meetingId',
    );
    return _data(response)['myRole'] as String;
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
