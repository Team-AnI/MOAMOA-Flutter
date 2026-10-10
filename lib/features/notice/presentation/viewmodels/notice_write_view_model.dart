import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/create_notice.dart';
import '../../domain/usecases/set_notice_pinned.dart';
import '../../domain/usecases/update_notice.dart';
import '../providers/notice_providers.dart';

/// 공지 작성 / 수정 ViewModel (family 인자: meetingId)
///
/// 상태는 등록 요청의 진행 상황입니다. (대기 / 등록 중 / 실패)
class NoticeWriteViewModel extends AsyncNotifier<void> {
  NoticeWriteViewModel(this._meetingId);

  final int _meetingId;

  @override
  FutureOr<void> build() {}

  /// [noticeId] 가 없으면 작성, 있으면 수정합니다.
  ///
  /// 작성일 때 [pinToTop] 이면 새 공지를 목록 맨 위에 고정합니다.
  /// 수정일 때는 [pinToTop] 이 기존 고정 여부([wasPinned])와 다르면 고정 상태를 바꿉니다.
  /// [isImportant] 는 중요 공지 표시 여부입니다.
  /// 성공하면 true 를 반환하고 목록(수정이면 상세도)을 다시 불러옵니다.
  /// 실패하면 false 를 반환하고, 상태의 error 에 원인이 담깁니다.
  ///
  /// 요청 중에 화면을 닫아도 provider 를 살려 두어, 서버에 등록된 공지가
  /// 목록에 바로 보이도록 끝까지 처리합니다.
  Future<bool> submit({
    int? noticeId,
    required String title,
    required String content,
    bool pinToTop = false,
    bool wasPinned = false,
    bool isImportant = false,
  }) async {
    if (state.isLoading) return false;

    final keepAlive = ref.keepAlive();
    try {
      return await _submit(
        noticeId: noticeId,
        title: title,
        content: content,
        pinToTop: pinToTop,
        wasPinned: wasPinned,
        isImportant: isImportant,
      );
    } finally {
      keepAlive.close();
    }
  }

  Future<bool> _submit({
    int? noticeId,
    required String title,
    required String content,
    required bool pinToTop,
    required bool wasPinned,
    required bool isImportant,
  }) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      if (noticeId == null) {
        final createdId = await ref.read(createNoticeProvider)(
          CreateNoticeParams(
            meetingId: _meetingId,
            title: title,
            content: content,
            isImportant: isImportant,
          ),
        );
        if (pinToTop) await _setPinned(createdId, pinned: true);
      } else {
        await ref.read(updateNoticeProvider)(
          UpdateNoticeParams(
            meetingId: _meetingId,
            noticeId: noticeId,
            title: title,
            content: content,
            isImportant: isImportant,
          ),
        );
        if (pinToTop != wasPinned) {
          await _setPinned(noticeId, pinned: pinToTop);
        }
      }
    });
    if (!ref.mounted) return false;
    state = result;
    if (result.hasError) return false;

    ref.invalidate(noticeListProvider(_meetingId));
    if (noticeId != null) {
      ref.invalidate(
        noticeDetailProvider((meetingId: _meetingId, noticeId: noticeId)),
      );
    }
    return true;
  }

  /// 공지는 이미 등록됐으므로, 고정 상태를 바꾸지 못해도 작성·수정은 성공으로 처리합니다.
  Future<void> _setPinned(int noticeId, {required bool pinned}) async {
    try {
      await ref.read(setNoticePinnedProvider)(
        SetNoticePinnedParams(
          meetingId: _meetingId,
          noticeId: noticeId,
          pinned: pinned,
        ),
      );
    } catch (_) {
      // 공지 상세에서 다시 고정하거나 해제할 수 있습니다.
    }
  }
}
