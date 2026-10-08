import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/notice.dart';
import '../providers/notice_providers.dart';
import '../viewmodels/notice_list_state.dart';
import '../widgets/notice_colors.dart';
import '../widgets/notice_error_view.dart';

/// 공지 목록 화면
class NoticeListPage extends ConsumerStatefulWidget {
  const NoticeListPage({super.key, required this.meetingId});

  final int meetingId;

  @override
  ConsumerState<NoticeListPage> createState() => _NoticeListPageState();
}

class _NoticeListPageState extends ConsumerState<NoticeListPage> {
  final _scrollController = ScrollController();

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
    final isAdmin =
        ref.watch(noticeMyRoleProvider(widget.meetingId)).value?.isAdmin ??
        false;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(onWrite: isAdmin ? _goWrite : null),
            Expanded(
              child: notices.when(
                data: (state) => state.isEmpty
                    ? _EmptyView(onWrite: isAdmin ? _goWrite : null)
                    : _NoticeListView(
                        state: state,
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

/// "공지" 제목 + (관리자만) 작성 버튼
class _Header extends StatelessWidget {
  const _Header({this.onWrite});

  final VoidCallback? onWrite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            const Expanded(
              child: Text(
                '공지',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: NoticeColors.text,
                ),
              ),
            ),
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

/// 공지들을 하나의 회색 박스 안에 구분선으로 나눠 보여줍니다.
class _NoticeListView extends StatelessWidget {
  const _NoticeListView({
    required this.state,
    required this.controller,
    required this.onRefresh,
    required this.onTapNotice,
  });

  final NoticeListState state;
  final ScrollController controller;
  final Future<void> Function() onRefresh;
  final ValueChanged<Notice> onTapNotice;

  @override
  Widget build(BuildContext context) {
    final notices = state.notices;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        itemCount: notices.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == notices.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final notice = notices[index];
          return _NoticeTile(
            notice: notice,
            isFirst: index == 0,
            isLast: index == notices.length - 1,
            onTap: () => onTapNotice(notice),
          );
        },
      ),
    );
  }
}

/// 회색 박스의 한 칸. 첫 칸은 위쪽, 마지막 칸은 아래쪽 모서리만 둥글게 합니다.
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
      top: isFirst ? const Radius.circular(16) : Radius.zero,
      bottom: isLast ? const Radius.circular(16) : Radius.zero,
    );

    return Material(
      color: NoticeColors.gray,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: isFirst
                  ? null
                  : const Border(top: BorderSide(color: NoticeColors.divider)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notice.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: NoticeColors.text,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _formatRelative(notice.createdAt),
                  style: const TextStyle(
                    fontSize: 13,
                    color: NoticeColors.subText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 공지가 없을 때. 관리자에게는 작성 버튼을 보여줍니다.
class _EmptyView extends StatelessWidget {
  const _EmptyView({this.onWrite});

  final VoidCallback? onWrite;

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
