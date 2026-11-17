import 'package:dio/dio.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/errors/dio_exception_mapper.dart';

import '../../domain/entities/notice.dart';
import '../../domain/entities/notice_list_result.dart';
import '../../domain/entities/notice_reads.dart';
import '../../domain/repositories/notice_repository.dart';
import '../datasources/notice_remote_data_source.dart';
import '../models/create_notice_request.dart';
import '../models/delete_notice_request.dart';
import '../models/fetch_notice_detail_request.dart';
import '../models/fetch_notice_reads_request.dart';
import '../models/fetch_notices_request.dart';
import '../models/mark_notice_read_request.dart';
import '../models/notice_list_model.dart';
import '../models/notice_model.dart';
import '../models/notice_reads_model.dart';
import '../models/update_notice_request.dart';

/// DataSource 의 응답을 Entity 로 바꾸고, 실패하면 공통 예외 [ApiException] 을 던집니다.
class NoticeRepositoryImpl implements NoticeRepository {
  const NoticeRepositoryImpl({
    required NoticeRemoteDataSource noticeRemoteDataSource,
  }) : _noticeRemoteDataSource = noticeRemoteDataSource;

  final NoticeRemoteDataSource _noticeRemoteDataSource;

  @override
  Future<NoticeListResult> getNotices({
    required int meetingId,
    required int page,
    required int size,
  }) {
    return _guard(() async {
      final response = await _noticeRemoteDataSource.fetchNotices(
        FetchNoticesRequest(meetingId: meetingId, page: page, size: size),
      );
      return response.toEntity();
    });
  }

  @override
  Future<Notice> getNoticeDetail({
    required int meetingId,
    required int noticeId,
  }) {
    return _guard(() async {
      final response = await _noticeRemoteDataSource.fetchNoticeDetail(
        FetchNoticeDetailRequest(meetingId: meetingId, noticeId: noticeId),
      );
      return response.toEntity();
    });
  }

  @override
  Future<int> createNotice({
    required int meetingId,
    required String title,
    required String content,
  }) {
    return _guard(
      () => _noticeRemoteDataSource.createNotice(
        CreateNoticeRequest(
          meetingId: meetingId,
          title: title,
          content: content,
        ),
      ),
    );
  }

  @override
  Future<void> updateNotice({
    required int meetingId,
    required int noticeId,
    String? title,
    String? content,
  }) {
    return _guard(
      () => _noticeRemoteDataSource.updateNotice(
        UpdateNoticeRequest(
          meetingId: meetingId,
          noticeId: noticeId,
          title: title,
          content: content,
        ),
      ),
    );
  }

  @override
  Future<void> deleteNotice({required int meetingId, required int noticeId}) {
    return _guard(
      () => _noticeRemoteDataSource.deleteNotice(
        DeleteNoticeRequest(meetingId: meetingId, noticeId: noticeId),
      ),
    );
  }

  @override
  Future<void> markNoticeRead({required int meetingId, required int noticeId}) {
    return _guard(
      () => _noticeRemoteDataSource.markNoticeRead(
        MarkNoticeReadRequest(meetingId: meetingId, noticeId: noticeId),
      ),
    );
  }

  @override
  Future<NoticeReads> getNoticeReadsByNoticeId({
    required int meetingId,
    required int noticeId,
  }) {
    return _guard(() async {
      final response = await _noticeRemoteDataSource.fetchNoticeReads(
        FetchNoticeReadsRequest(meetingId: meetingId, noticeId: noticeId),
      );
      return response.toEntity();
    });
  }

  /// Dio 오류와 응답 해석 실패를 공통 예외 [ApiException] 으로 바꿉니다.
  ///
  /// 성공 응답을 모델로 바꾸다 형식이 달라 실패하면(fromJson 의 TypeError·FormatException)
  /// 서버 응답을 알 수 없는 경우로 보고 unknown 으로 바꿉니다.
  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw e.toApiException();
    } on FormatException {
      throw const ApiException(code: ApiErrorCode.unknown);
    } on TypeError {
      throw const ApiException(code: ApiErrorCode.unknown);
    }
  }
}
