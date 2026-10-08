import '../models/notice_list_model.dart';
import '../models/notice_model.dart';
import '../models/notice_request_model.dart';

/// 공지 API 호출
abstract interface class NoticeRemoteDataSource {
  /// GET /v1/meetings/{meetingId}/notices
  Future<NoticeListModel> fetchNotices({
    required int meetingId,
    required int page,
    required int size,
  });

  /// GET /v1/meetings/{meetingId}/notices/{noticeId}
  Future<NoticeModel> fetchNoticeDetail({
    required int meetingId,
    required int noticeId,
  });

  /// POST /v1/meetings/{meetingId}/notices. 생성된 noticeId 를 반환합니다.
  Future<int> createNotice({
    required int meetingId,
    required NoticeRequestModel request,
  });

  /// PATCH /v1/meetings/{meetingId}/notices/{noticeId}
  Future<void> updateNotice({
    required int meetingId,
    required int noticeId,
    required NoticeRequestModel request,
  });

  /// DELETE /v1/meetings/{meetingId}/notices/{noticeId}
  Future<void> deleteNotice({required int meetingId, required int noticeId});

  /// GET /v1/meetings/{meetingId} 의 myRole ("ADMIN" / "MEMBER")
  Future<String> fetchMyRole({required int meetingId});
}
