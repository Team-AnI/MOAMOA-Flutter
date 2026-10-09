import '../entities/member_role.dart';
import '../entities/notice.dart';
import '../entities/notice_list_result.dart';

/// 공지 Repository
///
/// 실패하면 `NoticeException` 을 던집니다.
abstract interface class NoticeRepository {
  /// 3-2 공지 목록 (최신순, 페이지 단위)
  Future<NoticeListResult> getNotices({
    required int meetingId,
    required int page,
    required int size,
  });

  /// 3-3 공지 상세
  Future<Notice> getNoticeDetail({
    required int meetingId,
    required int noticeId,
  });

  /// 3-1 공지 작성. 생성된 noticeId 를 반환합니다.
  Future<int> createNotice({
    required int meetingId,
    required String title,
    required String content,
  });

  /// 3-4 공지 수정. 보낸 필드만 변경됩니다.
  Future<void> updateNotice({
    required int meetingId,
    required int noticeId,
    String? title,
    String? content,
  });

  /// 3-5 공지 삭제
  Future<void> deleteNotice({required int meetingId, required int noticeId});

  /// 1-4 모임 상세의 myRole. 작성·수정·삭제 버튼 노출에 사용합니다.
  Future<MemberRole> getMyRole({required int meetingId});

  /// 공지 고정 / 고정 해제 (후순위 API: POST·DELETE .../notices/{noticeId}/pin)
  Future<void> setPinned({
    required int meetingId,
    required int noticeId,
    required bool pinned,
  });
}
