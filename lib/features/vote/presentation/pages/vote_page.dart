import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/moa_snack_bar.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';

import '../../domain/entities/vote.dart';
import '../../domain/entities/vote_status.dart';
import '../providers/vote_providers.dart';
import '../viewmodels/vote_confirm_state.dart';
import '../viewmodels/vote_confirm_status.dart';
import '../vote_display.dart';
import '../vote_format.dart';
import '../vote_id.dart';
import '../widgets/vote_colors.dart';
import '../widgets/vote_confirm_sheet.dart';
import '../widgets/vote_primary_button.dart';

/// 일정 투표 화면입니다. 후보 시간마다 가능 인원을 표로 보여주고, 관리자는 응답 현황을 보고 일정을 확정합니다.
/// (Figma "[P0] 일정 투표" 관리자 44:16095, 구성원 533:1120)
///
/// - 표: 열은 후보 날짜, 줄은 후보 시각입니다. 칸 숫자는 가능 인원이고 많을수록 진합니다. 내가 고른 칸은 테두리로 표시합니다.
/// - 응답 현황: 관리자는 응답·미응답 수와 미응답 구성원 이름을, 구성원은 응답 인원만 봅니다.
/// - 확정(관리자): "일정 확정하기" → 확정 시트에서 후보를 고르면 확정하고, 성공하면 true 를 돌려주며 화면을 닫습니다.
///   일정 목록 갱신은 이 화면을 연 쪽(일정 목록)이 돌려받은 값을 보고 합니다.
/// - 내 가능 시간 고르기·저장(구성원 응답, API 5-3)은 다음 단계에서 붙입니다.
///
/// 투표는 [voteProvider] 로 조회하고, 확정 과정은 [voteConfirmProvider] 가 관리합니다.
class VotePage extends ConsumerWidget {
  const VotePage({
    super.key,
    required this.meetingId,
    required this.scheduleId,
  });

  final int meetingId;
  final int scheduleId;

  VoteId get _id => VoteId(meetingId: meetingId, scheduleId: scheduleId);

  /// 확정 상태가 바뀌면: 성공이면 true 를 돌려주며 닫고, 실패하면 안내합니다.
  void _onConfirmChanged(
    BuildContext context,
    VoteConfirmState? previous,
    VoteConfirmState next,
  ) {
    if (previous?.status == next.status) return;
    if (next.status == VoteConfirmStatus.success) {
      context.pop(true);
    } else if (next.status == VoteConfirmStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(next.errorMessage ?? '일정을 확정하지 못했어요')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      voteConfirmProvider(_id),
      (previous, next) => _onConfirmChanged(context, previous, next),
    );
    final confirming = ref.watch(
      voteConfirmProvider(_id)
          .select((s) => s.status == VoteConfirmStatus.submitting),
    );
    final vote = ref.watch(voteProvider(_id));
    final isAdmin = ref.watch(voteAdminProvider(meetingId));

    // 확정 중에 닫으면 목록이 결과를 받지 못해 갱신되지 않습니다.
    // 시스템 뒤로가기·스와이프만 막습니다. 상단 바 버튼은 context.pop 이라 PopScope 를 거치지 않습니다.
    return PopScope(
      canPop: !confirming,
      child: Scaffold(
        backgroundColor: MoaColors.page,
        // 공유 버튼은 투표를 불러온 뒤에만 보여줍니다.
        appBar: MoaAppBar(
          actions: [
            if (vote.value case final loaded?) _ShareButton(vote: loaded),
          ],
        ),
        body: SafeArea(
          child: vote.when(
            data: (vote) => Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _Heading(vote: vote, isAdmin: isAdmin),
                        _CandidateTable(vote: vote, isAdmin: isAdmin),
                        _ResponsesCard(id: _id, vote: vote),
                      ],
                    ),
                  ),
                ),
                _ConfirmBar(id: _id, vote: vote),
              ],
            ),
            error: (e, _) => _Message(
              text: e.voteErrorMessage,
              onRetry: () => ref.invalidate(voteProvider(_id)),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

/// 오른쪽 위의 공유 버튼입니다. (Figma "ph:share-network")
///
/// 공유할 링크가 아직 없어서, 지금은 투표 이름과 상태를 문구로 복사합니다.
/// 공유 시트와 링크는 공유 동작이 정해지면 이어서 붙입니다. (#124)
class _ShareButton extends StatelessWidget {
  const _ShareButton({required this.vote});

  final Vote vote;

  Future<void> _share(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: vote.shareText));
    if (!context.mounted) return;
    showMoaSnackBar(context, message: '투표 내용을 복사했어요');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: IconButton(
        tooltip: '공유',
        onPressed: () => _share(context),
        style: IconButton.styleFrom(
          backgroundColor: MoaColors.fill,
          fixedSize: const Size(40, 40),
        ),
        icon: SvgPicture.asset(
          'assets/icons/share_network.svg',
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}

/// 상태 알약(예: 투표 중 · 9월 20일 마감), 일정 이름, 상태별 안내 문구입니다.
/// 알약은 글자 너비만큼만 차지합니다.
class _Heading extends StatelessWidget {
  const _Heading({required this.vote, required this.isAdmin});

  final Vote vote;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    final (pillBackground, pillForeground) = vote.statusPillColors;
    final subtitle = vote.subtitleFor(isAdmin: isAdmin);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Container(
            height: 26,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: pillBackground,
              borderRadius: const BorderRadius.all(Radius.circular(9999)),
            ),
            child: Center(
              widthFactor: 1,
              child: Text(
                vote.statusLabelFor(isAdmin: isAdmin),
                style: MoaText.captionStrong.copyWith(color: pillForeground),
              ),
            ),
          ),
          Text(vote.title, style: MoaText.titleXl),
          if (subtitle != null)
            Text(
              subtitle,
              style: MoaText.body.copyWith(color: MoaColors.textSecondary),
            ),
        ],
      ),
    );
  }
}

/// 후보 표와 색 안내입니다. 열은 후보 날짜, 줄은 후보 시각이고, 그 날짜·시각에 후보가 없으면 빈 칸입니다.
/// (Figma "후보가 많을 때")
///
/// - 날짜가 [voteFlexDates] 개 이하이면 칸이 표 폭을 나눠 채우고, 더 많으면 칸을 [_wideCellWidth] 로 두고 옆으로 넘깁니다.
/// - 시각 줄이 많아 높이가 [_maxBodyHeight] 를 넘으면 그 높이로 고정하고 위아래로 넘깁니다.
/// - 날짜 머리줄과 시각 열은 제자리에 두고, 칸 영역을 넘기면 같은 만큼 따라갑니다.
/// 화면에서 한 단계만 나누므로, 50줄을 넘어도 안에서 다시 나누지 않고 구역을 주석으로 표시합니다.
class _CandidateTable extends StatefulWidget {
  const _CandidateTable({required this.vote, required this.isAdmin});

  final Vote vote;
  final bool isAdmin;

  @override
  State<_CandidateTable> createState() => _CandidateTableState();
}

class _CandidateTableState extends State<_CandidateTable> {
  /// 시각 열 너비
  static const _timeWidth = 44.0;

  /// 날짜가 많을 때 날짜 칸 너비
  static const _wideCellWidth = 76.0;

  /// 칸 영역의 가장 큰 높이. 시각 줄이 6.5개 보이는 높이입니다.
  static const _maxBodyHeight = 286.0;

  static const _gap = 6.0;
  static const _headerHeight = 16.0;
  static const _cellHeight = 38.0;

  static const _cellRadius = BorderRadius.all(Radius.circular(12));
  static const _swatchRadius = BorderRadius.all(Radius.circular(4));

  /// 날짜 머리줄과 시각 열은 직접 넘기지 않고, 칸 영역([_gridX], [_gridY])을 따라갑니다.
  final _datesX = ScrollController();
  final _timesY = ScrollController();
  final _gridX = ScrollController();
  final _gridY = ScrollController();

  @override
  void initState() {
    super.initState();
    _gridX.addListener(() => _follow(_datesX, _gridX));
    _gridY.addListener(() => _follow(_timesY, _gridY));
  }

  @override
  void dispose() {
    _datesX.dispose();
    _timesY.dispose();
    _gridX.dispose();
    _gridY.dispose();
    super.dispose();
  }

  /// [follower] 를 [leader] 와 같은 위치로 옮깁니다.
  void _follow(ScrollController follower, ScrollController leader) {
    if (!follower.hasClients || !leader.hasClients) return;
    final target = leader.offset.clamp(
      follower.position.minScrollExtent,
      follower.position.maxScrollExtent,
    );
    if (follower.offset != target) follower.jumpTo(target);
  }

  /// 칸 영역의 스크롤바. 시안처럼 얇은 회색 막대입니다.
  Widget _scrollbar({
    required ScrollController controller,
    required ScrollbarOrientation orientation,
    required bool Function(ScrollNotification) notificationPredicate,
    required Widget child,
  }) => RawScrollbar(
    controller: controller,
    scrollbarOrientation: orientation,
    notificationPredicate: notificationPredicate,
    thumbVisibility: true,
    thickness: 3,
    radius: const Radius.circular(2),
    thumbColor: VoteColors.textDisabled,
    child: child,
  );

  @override
  Widget build(BuildContext context) {
    final vote = widget.vote;
    final isAdmin = widget.isAdmin;
    final dates = vote.candidateDates;
    final times = vote.candidateTimes;
    final captionStyle = MoaText.caption.copyWith(
      color: MoaColors.textSecondary,
    );

    return Opacity(
      opacity: vote.tableOpacity,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: const BoxDecoration(
          color: MoaColors.fill,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Column(
          spacing: 10,
          children: [
            LayoutBuilder(
              builder: (_, constraints) {
                // 칸 영역 폭에서 날짜 칸 너비를 정합니다.
                final viewportWidth = constraints.maxWidth - _timeWidth - _gap;
                final dateCount = math.max(dates.length, 1);
                final cellWidth = dates.length <= voteFlexDates
                    ? (viewportWidth - _gap * (dateCount - 1)) / dateCount
                    : _wideCellWidth;
                final contentHeight =
                    times.length * _cellHeight +
                    math.max(times.length - 1, 0) * _gap;
                final bodyHeight = math.min(contentHeight, _maxBodyHeight);

                return Column(
                  spacing: _gap,
                  children: [
                    // 날짜 머리줄 (고정, 옆으로만 따라감)
                    SizedBox(
                      height: _headerHeight,
                      child: Row(
                        spacing: _gap,
                        children: [
                          const SizedBox(width: _timeWidth),
                          Expanded(
                            child: SingleChildScrollView(
                              controller: _datesX,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              child: Row(
                                spacing: _gap,
                                children: [
                                  for (final date in dates)
                                    SizedBox(
                                      width: cellWidth,
                                      child: Text(
                                        date.shortDateLabel,
                                        textAlign: TextAlign.center,
                                        style: MoaText.captionStrong.copyWith(
                                          color: MoaColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 시각 열(고정, 위아래로만 따라감)과 칸 영역(가로·세로로 넘김)
                    SizedBox(
                      height: bodyHeight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: _gap,
                        children: [
                          SizedBox(
                            width: _timeWidth,
                            child: SingleChildScrollView(
                              controller: _timesY,
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                spacing: _gap,
                                children: [
                                  for (final time in times)
                                    SizedBox(
                                      height: _cellHeight,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          time.hhmm,
                                          style: captionStyle,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: _scrollbar(
                              controller: _gridX,
                              orientation: ScrollbarOrientation.bottom,
                              notificationPredicate: (n) => n.depth == 1,
                              child: _scrollbar(
                                controller: _gridY,
                                orientation: ScrollbarOrientation.right,
                                notificationPredicate: (n) => n.depth == 0,
                                child: SingleChildScrollView(
                                  key: const Key('vote-grid'),
                                  controller: _gridY,
                                  child: SingleChildScrollView(
                                    controller: _gridX,
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      spacing: _gap,
                                      children: [
                                        for (final time in times)
                                          Row(
                                            spacing: _gap,
                                            children: [
                                              for (final date in dates)
                                                SizedBox(
                                                  width: cellWidth,
                                                  height: _cellHeight,
                                                  child: switch (vote
                                                      .candidateAt(
                                                        date,
                                                        time,
                                                      )) {
                                                    null => null,
                                                    final candidate => Opacity(
                                                      opacity: vote
                                                          .cellOpacityOf(
                                                            candidate,
                                                            isAdmin: isAdmin,
                                                          ),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                              color: vote
                                                                  .heatColorOf(
                                                                    candidate,
                                                                  ),
                                                              borderRadius:
                                                                  _cellRadius,
                                                              border: candidate
                                                                  .mineBorder,
                                                            ),
                                                        child: Text(
                                                          '${candidate.availableCount}',
                                                          style: MoaText
                                                              .bodyStrong
                                                              .copyWith(
                                                                color: vote
                                                                    .heatTextColorOf(
                                                                      candidate,
                                                                    ),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  },
                                                ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            // 색 안내: 적음 → 많음, 내 선택
            Row(
              spacing: 4,
              children: [
                Text('적음', style: captionStyle),
                for (final color in VoteColors.heat.skip(1))
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: _swatchRadius,
                    ),
                  ),
                Text('많음', style: captionStyle),
                const Spacer(),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: _swatchRadius,
                    border: Border.all(color: MoaColors.textPrimary, width: 2),
                  ),
                ),
                Text('내 선택', style: captionStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 응답 현황 카드입니다. 관리자는 응답·미응답 수와 미응답 구성원 이름(API 5-4)을, 구성원은 응답 인원만 봅니다.
/// 참여 가능·불참 구분은 정해지지 않아 응답 여부만 보여줍니다.
class _ResponsesCard extends ConsumerWidget {
  const _ResponsesCard({required this.id, required this.vote});

  final VoteId id;
  final Vote vote;

  static const _decoration = BoxDecoration(
    color: MoaColors.fill,
    borderRadius: BorderRadius.all(Radius.circular(24)),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = Text('응답 현황', style: MoaText.bodyStrong);
    final countStyle = MoaText.subStrong.copyWith(color: MoaColors.accentText);

    // 구성원: 응답 인원만. 응답 현황 조회(5-4)는 관리자만 할 수 있어 부르지 않습니다.
    if (!ref.watch(voteAdminProvider(id.meetingId))) {
      return Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(16),
        decoration: _decoration,
        child: Row(
          children: [
            Expanded(child: title),
            Text(vote.respondedSummaryLabel, style: countStyle),
          ],
        ),
      );
    }

    final unresponded = ref
        .watch(voteResponsesProvider(id))
        .value
        ?.unrespondedNamesLabel;
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: _decoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          Row(
            children: [
              Expanded(child: title),
              Text(vote.respondedLabel, style: countStyle),
            ],
          ),
          // 응답 / 미응답 수
          Row(
            spacing: 8,
            children: [
              for (final (count, label, color) in [
                (vote.respondedCount, '응답', MoaColors.accentText),
                (vote.unrespondedCount, '미응답', MoaColors.textTertiary),
              ])
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const BoxDecoration(
                      color: MoaColors.raised,
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    child: Column(
                      spacing: 2,
                      children: [
                        Text(
                          '$count',
                          style: MoaText.titleM.copyWith(color: color),
                        ),
                        Text(
                          label,
                          style: MoaText.caption.copyWith(
                            color: MoaColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          if (unresponded != null)
            Text(
              unresponded,
              style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
            ),
        ],
      ),
    );
  }
}

/// 화면 아래 버튼입니다.
/// - 관리자에게는 확정할 수 있는 투표(투표 중·마감 뒤 확정 전)에서 "일정 확정하기" 를 보여주고, 확정 중에는 누를 수 없습니다.
/// - 확정된 투표는 모두에게 "일정 보기" 하나만 보여줍니다. (Figma 확정됨)
class _ConfirmBar extends ConsumerWidget {
  const _ConfirmBar({required this.id, required this.vote});

  final VoteId id;
  final Vote vote;

  /// 확정된 일정의 상세로 이동합니다. 뒤로 가면 투표 화면이 아니라 이전 화면(일정 목록)으로 돌아갑니다.
  /// 일정 상세 경로(`/meetings/:meetingId/schedules/:scheduleId`)를 그대로 씁니다.
  void _openSchedule(BuildContext context) => context.pushReplacement(
    '/meetings/${id.meetingId}/schedules/${id.scheduleId}',
  );

  /// 확정 시트에서 후보를 고르면 확정을 요청합니다. 그냥 닫으면 그대로 둡니다.
  Future<void> _openConfirmSheet(BuildContext context, WidgetRef ref) async {
    final meetingTime = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      // 전체 높이로 열릴 때 상태바·Dynamic Island 아래에서 시작하도록 합니다.
      useSafeArea: true,
      backgroundColor: MoaColors.page,
      barrierColor: MoaColors.scrim,
      shape: const RoundedRectangleBorder(),
      builder: (_) => VoteConfirmSheet(candidates: vote.rankedCandidates),
    );
    if (meetingTime == null || !context.mounted) return;
    ref.read(voteConfirmProvider(id).notifier).confirm(meetingTime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(voteAdminProvider(id.meetingId));
    final confirming = ref.watch(
      voteConfirmProvider(id)
          .select((s) => s.status == VoteConfirmStatus.submitting),
    );
    if (vote.status == VoteStatus.confirmed) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: VotePrimaryButton(
          label: '일정 보기',
          onPressed: () => _openSchedule(context),
        ),
      );
    }
    if (!isAdmin || !vote.canConfirm) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: VotePrimaryButton(
        label: '일정 확정하기',
        onPressed: confirming ? null : () => _openConfirmSheet(context, ref),
      ),
    );
  }
}

/// 화면 가운데의 안내 문구와 "다시 시도" 버튼입니다.
class _Message extends StatelessWidget {
  const _Message({required this.text, required this.onRetry});

  final String text;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: MoaText.body.copyWith(color: MoaColors.textTertiary),
          ),
          TextButton(onPressed: onRetry, child: const Text('다시 시도')),
        ],
      ),
    );
  }
}
