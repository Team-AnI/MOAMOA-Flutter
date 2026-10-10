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

/// 공지 API 호출
abstract interface class NoticeRemoteDataSource {
  /// GET /v1/meetings/{meetingId}/notices
  Future<NoticeListModel> fetchNotices(FetchNoticesRequest request);

  /// GET /v1/meetings/{meetingId}/notices/{noticeId}
  Future<NoticeModel> fetchNoticeDetail(FetchNoticeDetailRequest request);

  /// POST /v1/meetings/{meetingId}/notices. 생성된 noticeId 를 반환합니다.
  Future<int> createNotice(CreateNoticeRequest request);

  /// PATCH /v1/meetings/{meetingId}/notices/{noticeId}
  Future<void> updateNotice(UpdateNoticeRequest request);

  /// DELETE /v1/meetings/{meetingId}/notices/{noticeId}
  Future<void> deleteNotice(DeleteNoticeRequest request);

  /// GET /v1/meetings/{meetingId} 의 myRole ("ADMIN" / "MEMBER")
  Future<String> fetchMyRole(FetchMyRoleRequest request);

  /// POST /v1/meetings/{meetingId}/notices/{noticeId}/pin
  Future<void> pinNotice(PinNoticeRequest request);

  /// DELETE /v1/meetings/{meetingId}/notices/{noticeId}/pin
  Future<void> unpinNotice(UnpinNoticeRequest request);
}
