import 'package:dio/dio.dart';

import '../../domain/entities/member_role.dart';
import '../../domain/entities/notice.dart';
import '../../domain/entities/notice_exception.dart';
import '../../domain/entities/notice_list_result.dart';
import '../../domain/repositories/notice_repository.dart';
import '../datasources/notice_remote_data_source.dart';
import '../models/create_notice_request.dart';
import '../models/delete_notice_request.dart';
import '../models/fetch_my_role_request.dart';
import '../models/fetch_notice_detail_request.dart';
import '../models/fetch_notices_request.dart';
import '../models/pin_notice_request.dart';
import '../models/unpin_notice_request.dart';
import '../models/update_notice_request.dart';

/// DataSource 의 응답을 Entity 로 바꾸고, DioException 을 NoticeException 으로 바꿉니다.
class NoticeRepositoryImpl implements NoticeRepository {
  const NoticeRepositoryImpl({required NoticeRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final NoticeRemoteDataSource _remoteDataSource;

  @override
  Future<NoticeListResult> getNotices({
    required int meetingId,
    required int page,
    required int size,
  }) {
    return _guard(() async {
      final response = await _remoteDataSource.fetchNotices(
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
      final response = await _remoteDataSource.fetchNoticeDetail(
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
    bool isImportant = false,
  }) {
    return _guard(
      () => _remoteDataSource.createNotice(
        CreateNoticeRequest(
          meetingId: meetingId,
          title: title,
          content: content,
          isImportant: isImportant,
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
    bool? isImportant,
  }) {
    return _guard(
      () => _remoteDataSource.updateNotice(
        UpdateNoticeRequest(
          meetingId: meetingId,
          noticeId: noticeId,
          title: title,
          content: content,
          isImportant: isImportant,
        ),
      ),
    );
  }

  @override
  Future<void> deleteNotice({required int meetingId, required int noticeId}) {
    return _guard(
      () => _remoteDataSource.deleteNotice(
        DeleteNoticeRequest(meetingId: meetingId, noticeId: noticeId),
      ),
    );
  }

  @override
  Future<MemberRole> getMyRole({required int meetingId}) {
    return _guard(() async {
      final role = await _remoteDataSource.fetchMyRole(
        FetchMyRoleRequest(meetingId: meetingId),
      );
      return role == 'ADMIN' ? MemberRole.admin : MemberRole.member;
    });
  }

  @override
  Future<void> setPinned({
    required int meetingId,
    required int noticeId,
    required bool pinned,
  }) {
    return _guard(
      () => pinned
          ? _remoteDataSource.pinNotice(
              PinNoticeRequest(meetingId: meetingId, noticeId: noticeId),
            )
          : _remoteDataSource.unpinNotice(
              UnpinNoticeRequest(meetingId: meetingId, noticeId: noticeId),
            ),
    );
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
    // 응답 자체를 받지 못한 경우(연결 실패, 시간 초과)
    if (e.response == null) {
      return const NoticeException('네트워크 연결을 확인해주세요.');
    }
    // 응답은 받았지만 형식이 예상과 다른 경우
    return const NoticeException('요청을 처리하지 못했어요. 잠시 후 다시 시도해주세요.');
  }
}
