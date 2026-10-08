import 'package:dio/dio.dart';

import '../../domain/entities/member_role.dart';
import '../../domain/entities/notice.dart';
import '../../domain/entities/notice_exception.dart';
import '../../domain/entities/notice_list_result.dart';
import '../../domain/repositories/notice_repository.dart';
import '../datasources/notice_remote_data_source.dart';
import '../models/notice_request_model.dart';

/// DataSource 의 응답을 Entity 로 바꾸고, DioException 을 NoticeException 으로 바꿉니다.
class NoticeRepositoryImpl implements NoticeRepository {
  const NoticeRepositoryImpl({required this._remoteDataSource});

  final NoticeRemoteDataSource _remoteDataSource;

  @override
  Future<NoticeListResult> getNotices({
    required int meetingId,
    required int page,
    required int size,
  }) {
    return _guard(() async {
      final response = await _remoteDataSource.fetchNotices(
        meetingId: meetingId,
        page: page,
        size: size,
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
      final response = await _remoteDataSource.fetchNoticeDetail(
        meetingId: meetingId,
        noticeId: noticeId,
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
      () => _remoteDataSource.createNotice(
        meetingId: meetingId,
        request: NoticeRequestModel(title: title, content: content),
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
      () => _remoteDataSource.updateNotice(
        meetingId: meetingId,
        noticeId: noticeId,
        request: NoticeRequestModel(title: title, content: content),
      ),
    );
  }

  @override
  Future<void> deleteNotice({required int meetingId, required int noticeId}) {
    return _guard(
      () => _remoteDataSource.deleteNotice(
        meetingId: meetingId,
        noticeId: noticeId,
      ),
    );
  }

  @override
  Future<MemberRole> getMyRole({required int meetingId}) {
    return _guard(() async {
      final role = await _remoteDataSource.fetchMyRole(meetingId: meetingId);
      return role == 'ADMIN' ? MemberRole.admin : MemberRole.member;
    });
  }

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw _toNoticeException(e);
    }
  }

  /// 실패 응답 { error: { code, message } } 의 메시지를 그대로 사용합니다.
  NoticeException _toNoticeException(DioException e) {
    final body = e.response?.data;
    if (body is Map<String, dynamic>) {
      final error = body['error'];
      if (error is Map<String, dynamic> && error['message'] is String) {
        return NoticeException(
          error['message'] as String,
          code: error['code'] as String?,
        );
      }
    }
    return const NoticeException('네트워크 연결을 확인해주세요.');
  }
}
