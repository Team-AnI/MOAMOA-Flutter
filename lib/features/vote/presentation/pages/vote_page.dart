import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';

import '../../domain/entities/vote.dart';
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

    // 확정 중에 닫으면 목록이 결과를 받지 못해 갱신되지 않습니다.
    // 시스템 뒤로가기·스와이프만 막습니다. 상단 바 버튼은 context.pop 이라 PopScope 를 거치지 않습니다.
    return PopScope(
      canPop: !confirming,
      child: Scaffold(
        backgroundColor: MoaColors.page,
        appBar: MoaAppBar(),
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
                        _Heading(vote: vote),
                        _CandidateTable(vote: vote),
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

/// 상태 라벨(예: 투표 중 · 9월 20일 마감)과 일정 이름입니다.
class _Heading extends StatelessWidget {
  const _Heading({required this.vote});

  final Vote vote;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Container(
            height: 26,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: MoaColors.accentTint,
              borderRadius: BorderRadius.all(Radius.circular(9999)),
            ),
            child: Text(
              vote.statusLabel,
              style: MoaText.captionStrong.copyWith(
                color: MoaColors.accentText,
              ),
            ),
          ),
          Text(vote.title, style: MoaText.titleXl),
        ],
      ),
    );
  }
}

/// 후보 표와 색 안내입니다. 열은 후보 날짜, 줄은 후보 시각이고, 그 날짜·시각에 후보가 없으면 빈 칸입니다.
/// 날짜가 많아 칸이 [_minCellWidth] 보다 좁아지면 날짜 열만 옆으로 넘기고, 시각 열은 제자리에 둡니다.
/// 화면에서 한 단계만 나누므로, 50줄을 넘어도 안에서 다시 나누지 않고 구역을 주석으로 표시합니다.
class _CandidateTable extends StatelessWidget {
  const _CandidateTable({required this.vote});

  final Vote vote;

  /// 시각 열 너비
  static const _timeWidth = 44.0;

  /// 날짜 칸의 최소 너비. "10/13 화" 가 한 줄로 들어가는 너비입니다.
  static const _minCellWidth = 64.0;

  static const _gap = 6.0;
  static const _headerHeight = 20.0;
  static const _cellHeight = 38.0;

  static const _cellRadius = BorderRadius.all(Radius.circular(12));
  static const _swatchRadius = BorderRadius.all(Radius.circular(4));

  /// 날짜가 적으면 폭을 나눠 채우고, 많으면 최소 너비로 두고 옆으로 넘깁니다.
  double _cellWidthOf(double maxWidth) {
    final count = vote.candidateDates.length;
    return math.max((maxWidth - _gap * (count - 1)) / count, _minCellWidth);
  }

  @override
  Widget build(BuildContext context) {
    final captionStyle = MoaText.caption.copyWith(
      color: MoaColors.textSecondary,
    );

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: MoaColors.fill,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Column(
        spacing: 10,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: _gap,
            children: [
              // 시각 열 (날짜 머리줄 높이만큼 비우고 시작)
              SizedBox(
                width: _timeWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: _gap,
                  children: [
                    const SizedBox(height: _headerHeight),
                    for (final time in vote.candidateTimes)
                      SizedBox(
                        height: _cellHeight,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(time.hhmm, style: captionStyle),
                        ),
                      ),
                  ],
                ),
              ),
              // 날짜 열: 머리줄과 칸. 칸 숫자는 가능 인원입니다.
              Expanded(
                child: LayoutBuilder(
                  builder: (_, constraints) {
                    final cellWidth = _cellWidthOf(constraints.maxWidth);
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        spacing: _gap,
                        children: [
                          Row(
                            spacing: _gap,
                            children: [
                              for (final date in vote.candidateDates)
                                SizedBox(
                                  width: cellWidth,
                                  height: _headerHeight,
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
                          for (final time in vote.candidateTimes)
                            Row(
                              spacing: _gap,
                              children: [
                                for (final date in vote.candidateDates)
                                  SizedBox(
                                    width: cellWidth,
                                    height: _cellHeight,
                                    child: switch (vote.candidateAt(
                                      date,
                                      time,
                                    )) {
                                      null => null,
                                      final candidate => Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: vote.heatColorOf(candidate),
                                          borderRadius: _cellRadius,
                                          border: candidate.mineBorder,
                                        ),
                                        child: Text(
                                          '${candidate.availableCount}',
                                          style: MoaText.bodyStrong.copyWith(
                                            color: vote.heatTextColorOf(
                                              candidate,
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
                    );
                  },
                ),
              ),
            ],
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

/// 관리자에게만 보이는 "일정 확정하기" 버튼입니다. 투표 중일 때만 보이고, 확정 중에는 눌리지 않습니다.
class _ConfirmBar extends ConsumerWidget {
  const _ConfirmBar({required this.id, required this.vote});

  final VoteId id;
  final Vote vote;

  /// 확정 시트에서 후보를 고르면 확정을 요청합니다. 그냥 닫으면 그대로 둡니다.
  Future<void> _openConfirmSheet(BuildContext context, WidgetRef ref) async {
    final meetingTime = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
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
