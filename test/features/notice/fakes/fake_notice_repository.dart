import 'dart:async';

import 'package:moamoa/features/notice/domain/entities/member_role.dart';
import 'package:moamoa/features/notice/domain/entities/notice.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';
import 'package:moamoa/features/notice/domain/entities/notice_list_result.dart';
import 'package:moamoa/features/notice/domain/repositories/notice_repository.dart';

/// 테스트용 공지 생성 헬퍼
Notice buildNotice(
  int id, {
  String? title,
  String? content,
  String? authorName,
  bool isPinned = false,
}) {
  return Notice(
    id: id,
    title: title ?? '공지 $id',
    content: content,
    authorName: authorName,
    isPinned: isPinned,
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

  /// 페이지별로 응답을 붙잡아 두는 장치. 넣어 둔 Completer 를 complete 해야 응답합니다.
  /// (요청 완료 순서가 뒤바뀌는 상황을 재현할 때 사용)
  final Map<int, Completer<void>> pageGates = {};

  /// 값이 있으면 getNoticeDetail 응답을 complete 될 때까지 붙잡아 둡니다.
  Completer<void>? detailGate;

  /// 값이 있으면 createNotice 응답을 complete 될 때까지 붙잡아 둡니다.
  Completer<void>? createGate;

  /// 값이 있으면 getMyRole 만 이 예외를 던집니다. (역할 조회만 실패하는 상황)
  NoticeException? myRoleError;

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

  Notice _copy(Notice old, {String? title, String? content, bool? isPinned}) {
    return Notice(
      id: old.id,
      title: title ?? old.title,
      content: content ?? old.content,
      createdAt: old.createdAt,
      authorName: old.authorName,
      isPinned: isPinned ?? old.isPinned,
      account: old.account,
    );
  }

  @override
  Future<NoticeListResult> getNotices({
    required int meetingId,
    required int page,
    required int size,
  }) async {
    getNoticesCallCount++;
    _throwIfError();
    // 요청한 시점의 데이터로 응답을 만들고, 붙잡아 둔 경우 나중에 돌려줍니다.
    final start = (page * size).clamp(0, notices.length);
    final end = (start + size).clamp(0, notices.length);
    final result = NoticeListResult(
      notices: notices.sublist(start, end),
      page: page,
      size: size,
      hasNext: end < notices.length,
    );
    await pageGates[page]?.future;
    return result;
  }

  @override
  Future<Notice> getNoticeDetail({
    required int meetingId,
    required int noticeId,
  }) async {
    await detailGate?.future;
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
    await createGate?.future;
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
    notices[index] = _copy(notices[index], title: title, content: content);
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
    if (myRoleError != null) throw myRoleError!;
    _throwIfError();
    return myRole;
  }

  @override
  Future<void> setPinned({
    required int meetingId,
    required int noticeId,
    required bool pinned,
  }) async {
    _throwIfError();
    final index = _indexOf(noticeId);
    notices[index] = _copy(notices[index], isPinned: pinned);
  }
}
