import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/notice.dart';
import '../providers/notice_providers.dart';
import '../viewmodels/notice_list_state.dart';
import '../widgets/notice_colors.dart';
import '../widgets/notice_error_view.dart';

enum _NoticeTab { all, important, pinned }

/// 공지 목록 화면
class NoticeListPage extends ConsumerStatefulWidget {
  const NoticeListPage({super.key, required this.meetingId});

  final int meetingId;

  @override
  ConsumerState<NoticeListPage> createState() => _NoticeListPageState();
}

class _NoticeListPageState extends ConsumerState<NoticeListPage> {
  final _scrollController = ScrollController();
  _NoticeTab _tab = _NoticeTab.all;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// 목록 끝에 가까워지면 다음 페이지를 불러옵니다.
  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels < position.maxScrollExtent - 200) return;
    ref
        .read(noticeListProvider(widget.meetingId).notifier)
        .loadMore()
        .catchError((Object error) => _showError(error));
  }

  void _showError(Object error) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(noticeErrorMessage(error))));
  }

  void _goWrite() => context.push('/meetings/${widget.meetingId}/notices/new');

  void _goDetail(Notice notice) =>
      context.push('/meetings/${widget.meetingId}/notices/${notice.id}');

  @override
  Widget build(BuildContext context) {
    final notices = ref.watch(noticeListProvider(widget.meetingId));
    final role = ref.watch(noticeMyRoleProvider(widget.meetingId));
    final isAdmin = role.value?.isAdmin ?? false;
    // 역할 조회에 실패하면 일반 구성원처럼 숨기지 않고 다시 시도할 수 있게 합니다.
    final VoidCallback? retryRole = role.hasError
        ? () => ref.invalidate(noticeMyRoleProvider(widget.meetingId))
        : null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(onWrite: isAdmin ? _goWrite : null, onRetryRole: retryRole),
            Expanded(
              child: notices.when(
                data: (state) => state.isEmpty
                    ? _EmptyView(
                        onWrite: isAdmin ? _goWrite : null,
                        onRetryRole: retryRole,
                      )
                    : _NoticeListBody(
                        state: state,
                        tab: _tab,
                        onTabChanged: (tab) => setState(() => _tab = tab),
                        controller: _scrollController,
                        onRefresh: () => ref
                            .read(noticeListProvider(widget.meetingId).notifier)
                            .refresh(),
                        onTapNotice: _goDetail,
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => NoticeErrorView(
                  error: error,
                  onAction: () =>
                      ref.invalidate(noticeListProvider(widget.meetingId)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "공지" 제목 + (관리자만) 작성 버튼 / (역할 조회 실패 시) 다시 시도 버튼
class _Header extends StatelessWidget {
  const _Header({this.onWrite, this.onRetryRole});

  final VoidCallback? onWrite;
  final VoidCallback? onRetryRole;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            const Expanded(
              child: Text(
                '공지',
                style: TextStyle(
                  fontSize: 26,
                  height: 1.35,
                  letterSpacing: -0.7,
                  fontWeight: FontWeight.w700,
                  color: NoticeColors.text,
                ),
              ),
            ),
            if (onRetryRole != null)
              NoticeRoleRetryButton(onPressed: onRetryRole!),
            if (onWrite != null)
              IconButton.filled(
                onPressed: onWrite,
                tooltip: '공지 작성',
                constraints: const BoxConstraints.tightFor(
                  width: 40,
                  height: 40,
                ),
                padding: EdgeInsets.zero,
                style: IconButton.styleFrom(backgroundColor: NoticeColors.text),
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// 전체 / 중요 / 고정 탭 + 공지 목록
class _NoticeListBody extends StatelessWidget {
  const _NoticeListBody({
    required this.state,
    required this.tab,
    required this.onTabChanged,
    required this.controller,
    required this.onRefresh,
    required this.onTapNotice,
  });

  final NoticeListState state;
  final _NoticeTab tab;
  final ValueChanged<_NoticeTab> onTabChanged;
  final ScrollController controller;
  final Future<void> Function() onRefresh;
  final ValueChanged<Notice> onTapNotice;

  @override
  Widget build(BuildContext context) {
    final allPinned = state.notices.where((notice) => notice.isPinned);
    final allOthers = state.notices.where((notice) => !notice.isPinned);
    final importantCount = state.notices
        .where((notice) => notice.isImportant)
        .length;

    // 고정된 공지는 파란 카드로 맨 위에, 나머지는 회색 박스에 보여줍니다.
    final pinned = switch (tab) {
      _NoticeTab.important => allPinned.where((n) => n.isImportant).toList(),
      _ => allPinned.toList(),
    };
    final others = switch (tab) {
      _NoticeTab.all => allOthers.toList(),
      _NoticeTab.important => allOthers.where((n) => n.isImportant).toList(),
      _NoticeTab.pinned => <Notice>[],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: _FilterTabs(
            allCount: state.notices.length,
            importantCount: importantCount,
            pinnedCount: allPinned.length,
            selected: tab,
            onChanged: onTabChanged,
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView(
              controller: controller,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              children: [
                if (pinned.isEmpty && others.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Center(
                      child: Text(
                        tab == _NoticeTab.important
                            ? '중요 공지가 없어요'
                            : '고정된 공지가 없어요',
                        style: const TextStyle(
                          fontSize: 15,
                          color: NoticeColors.subText,
                        ),
                      ),
                    ),
                  ),
                for (final notice in pinned) ...[
                  _PinnedNoticeCard(
                    notice: notice,
                    onTap: () => onTapNotice(notice),
                  ),
                  const SizedBox(height: 12),
                ],
                for (var i = 0; i < others.length; i++)
                  _NoticeTile(
                    notice: others[i],
                    isFirst: i == 0,
                    isLast: i == others.length - 1,
                    onTap: () => onTapNotice(others[i]),
                  ),
                if (state.isLoadingMore)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// 회색 배경 위에 선택된 탭만 흰색으로 떠 있는 탭
class _FilterTabs extends StatelessWidget {
  const _FilterTabs({
    required this.allCount,
    required this.importantCount,
    required this.pinnedCount,
    required this.selected,
    required this.onChanged,
  });

  final int allCount;
  final int importantCount;
  final int pinnedCount;
  final _NoticeTab selected;
  final ValueChanged<_NoticeTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: NoticeColors.gray,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        children: [
          _TabButton(
            label: '전체 $allCount',
            isSelected: selected == _NoticeTab.all,
            onTap: () => onChanged(_NoticeTab.all),
          ),
          _TabButton(
            label: '중요 $importantCount',
            isSelected: selected == _NoticeTab.important,
            onTap: () => onChanged(_NoticeTab.important),
          ),
          _TabButton(
            label: '고정 $pinnedCount',
            isSelected: selected == _NoticeTab.pinned,
            onTap: () => onChanged(_NoticeTab.pinned),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9999),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              height: 1.47,
              letterSpacing: -0.2,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? NoticeColors.text : NoticeColors.bodyText,
            ),
          ),
        ),
      ),
    );
  }
}

/// 고정된 공지 (파란 카드)
class _PinnedNoticeCard extends StatelessWidget {
  const _PinnedNoticeCard({required this.notice, required this.onTap});

  final Notice notice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NoticeColors.lightBlue,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.push_pin, size: 14, color: NoticeColors.blue),
                  SizedBox(width: 6),
                  Text(
                    '고정된 공지',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.33,
                      fontWeight: FontWeight.w600,
                      color: NoticeColors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                notice.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.41,
                  letterSpacing: -0.3,
                  fontWeight: FontWeight.w600,
                  color: NoticeColors.text,
                ),
              ),
              const SizedBox(height: 8),
              _MetaText(notice: notice),
            ],
          ),
        ),
      ),
    );
  }
}

/// 회색 박스의 한 칸. 첫 칸은 위쪽, 마지막 칸은 아래쪽 모서리만 둥글게 하고,
/// 박스 위아래에는 6 만큼 여백을 둡니다.
class _NoticeTile extends StatelessWidget {
  const _NoticeTile({
    required this.notice,
    required this.isFirst,
    required this.isLast,
    required this.onTap,
  });

  final Notice notice;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.vertical(
      top: isFirst ? const Radius.circular(24) : Radius.zero,
      bottom: isLast ? const Radius.circular(24) : Radius.zero,
    );

    return Material(
      color: NoticeColors.gray,
      borderRadius: radius,
      child: Padding(
        padding: EdgeInsets.only(top: isFirst ? 6 : 0, bottom: isLast ? 6 : 0),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: isFirst
                    ? null
                    : const Border(top: BorderSide(color: Colors.white)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (notice.isImportant) ...[
                    const _ImportantBadge(),
                    const SizedBox(height: 6),
                  ],
                  Text(
                    notice.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.47,
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w600,
                      color: NoticeColors.text,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _MetaText(notice: notice),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "김도윤 · 1일 전 · 수정됨". 작성자가 없으면 시간만 보여줍니다.
class _MetaText extends StatelessWidget {
  const _MetaText({required this.notice});

  final Notice notice;

  @override
  Widget build(BuildContext context) {
    final time = _formatRelative(notice.createdAt);
    final author = notice.authorName;
    const style = TextStyle(fontSize: 14, height: 1.43, letterSpacing: -0.1);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          author == null ? time : '$author · $time',
          style: style.copyWith(color: NoticeColors.bodyText),
        ),
        if (notice.isEdited) ...[
          const SizedBox(width: 6),
          Text('·', style: style.copyWith(color: NoticeColors.subText)),
          const SizedBox(width: 6),
          Text('수정됨', style: style.copyWith(color: NoticeColors.subText)),
        ],
      ],
    );
  }
}

/// 중요 공지 뱃지
class _ImportantBadge extends StatelessWidget {
  const _ImportantBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: NoticeColors.alertTint,
        borderRadius: BorderRadius.circular(9999),
      ),
      // 글자 크기만큼만 차지하면서 세로로 가운데 정렬합니다.
      child: const Center(
        widthFactor: 1,
        child: Text(
          '중요',
          style: TextStyle(
            fontSize: 12,
            height: 1.33,
            fontWeight: FontWeight.w600,
            color: NoticeColors.alert,
          ),
        ),
      ),
    );
  }
}

/// 공지가 없을 때. 관리자에게는 작성 버튼을 보여줍니다.
class _EmptyView extends StatelessWidget {
  const _EmptyView({this.onWrite, this.onRetryRole});

  final VoidCallback? onWrite;
  final VoidCallback? onRetryRole;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '아직 등록된 공지가 없어요',
            style: TextStyle(fontSize: 15, color: NoticeColors.subText),
          ),
          if (onRetryRole != null) ...[
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: onRetryRole,
              child: const Text('권한 다시 확인'),
            ),
          ],
          if (onWrite != null) ...[
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onWrite,
              style: FilledButton.styleFrom(
                backgroundColor: NoticeColors.text,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('공지 작성하기'),
            ),
          ],
        ],
      ),
    );
  }
}

/// 작성 시각을 "방금 전", "3시간 전", "1일 전", "1주 전", "9월 12일" 형태로 표시합니다.
String _formatRelative(DateTime createdAt) {
  final diff = DateTime.now().difference(createdAt);
  if (diff.inMinutes < 1) return '방금 전';
  if (diff.inHours < 1) return '${diff.inMinutes}분 전';
  if (diff.inDays < 1) return '${diff.inHours}시간 전';
  if (diff.inDays < 7) return '${diff.inDays}일 전';
  if (diff.inDays < 30) return '${diff.inDays ~/ 7}주 전';
  return '${createdAt.month}월 ${createdAt.day}일';
}
