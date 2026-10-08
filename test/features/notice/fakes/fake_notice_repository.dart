import 'package:moamoa/features/notice/domain/entities/member_role.dart';
import 'package:moamoa/features/notice/domain/entities/notice.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/domain/entities/notice_list_result.dart';
import 'package:moamoa/features/notice/domain/repositories/notice_repository.dart';

/// 테스트용 공지 생성 헬퍼
Notice buildNotice(int id, {String? title, String? content}) {
  return Notice(
    id: id,
    title: title ?? '공지 $id',
    content: content,
    createdAt: DateTime(2026, 10, 1).add(Duration(days: id)),
  );
}

/// 메모리에 공지를 저장하는 테스트용 Repository
class FakeNoticeRepository implements NoticeRepository {
  FakeNoticeRepository({List<Notice>? notices, this.myRole = MemberRole.member})
    : notices = [...?notices];

  /// 저장된 공지 (최신순)
  final List<Notice> notices;

  MemberRole myRole;

  /// 값이 있으면 모든 호출이 이 예외를 던집니다.
  NoticeException? error;

  /// getNotices 호출 횟수
  int getNoticesCallCount = 0;

  int _nextId = 1000;

  void _throwIfError() {
    if (error != null) throw error!;
  }

  int _indexOf(int noticeId) {
    final index = notices.indexWhere((notice) => notice.id == noticeId);
    if (index < 0) {
      throw const NoticeException('공지를 찾을 수 없습니다.', code: 'NOT_FOUND');
    }
    return index;
  }

  @override
  Future<NoticeListResult> getNotices({
    required int meetingId,
    required int page,
    required int size,
  }) async {
    getNoticesCallCount++;
    _throwIfError();
    final start = (page * size).clamp(0, notices.length);
    final end = (start + size).clamp(0, notices.length);
    return NoticeListResult(
      notices: notices.sublist(start, end),
      page: page,
      size: size,
      hasNext: end < notices.length,
    );
  }

  @override
  Future<Notice> getNoticeDetail({
    required int meetingId,
    required int noticeId,
  }) async {
    _throwIfError();
    return notices[_indexOf(noticeId)];
  }

  @override
  Future<int> createNotice({
    required int meetingId,
    required String title,
    required String content,
  }) async {
    _throwIfError();
    final id = _nextId++;
    notices.insert(
      0,
      Notice(id: id, title: title, content: content, createdAt: DateTime.now()),
    );
    return id;
  }

  @override
  Future<void> updateNotice({
    required int meetingId,
    required int noticeId,
    String? title,
    String? content,
  }) async {
    _throwIfError();
    final index = _indexOf(noticeId);
    final old = notices[index];
    notices[index] = Notice(
      id: old.id,
      title: title ?? old.title,
      content: content ?? old.content,
      createdAt: old.createdAt,
    );
  }

  @override
  Future<void> deleteNotice({
    required int meetingId,
    required int noticeId,
  }) async {
    _throwIfError();
    notices.removeAt(_indexOf(noticeId));
  }

  @override
  Future<MemberRole> getMyRole({required int meetingId}) async {
    _throwIfError();
    return myRole;
  }
}
