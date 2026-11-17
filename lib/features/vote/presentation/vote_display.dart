import 'package:flutter/material.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/profile_name.dart';

import '../domain/entities/vote.dart';
import '../domain/entities/vote_candidate.dart';
import '../domain/entities/vote_responses.dart';
import '../domain/entities/vote_status.dart';
import 'widgets/vote_colors.dart';

/// 날짜가 이 개수를 넘으면 표의 칸 너비를 고정하고 옆으로 넘깁니다. (Figma "후보가 많을 때")
const voteFlexDates = 3;

/// 시각 줄이 이 개수를 넘으면 표 높이를 고정하고 위아래로 넘깁니다. (칸 38 + 간격 6 으로 286 에 들어가는 줄 수)
const voteFlexTimes = 6;

/// 투표 화면에 보여줄 표·상태 값입니다. 서버가 UTC 로 줄 수 있어 시각은 toLocal() 한 값으로 나눕니다.
extension VoteDisplayX on Vote {
  /// 상단 상태 라벨. 투표 중이면 마감일을 함께 보여줍니다.
  String get statusLabel => switch (status) {
    VoteStatus.voting when votingOpen =>
      '투표 중 · ${voteDeadlineAt.toLocal().month}월 '
          '${voteDeadlineAt.toLocal().day}일 마감',
    VoteStatus.voting => '투표 마감',
    VoteStatus.confirmed => '확정',
    VoteStatus.canceled => '취소된 투표',
  };

  /// 상단 알약 문구. 관리자는 마감된 뒤에 "확정 전" 이라는 것도 함께 봅니다. (Figma 마감됨 관리자)
  String statusLabelFor({required bool isAdmin}) => switch (status) {
    VoteStatus.voting when !votingOpen && isAdmin => '투표 마감 · 확정 전',
    _ => statusLabel,
  };

  /// 알약의 (배경, 글자) 색. 투표 중·확정은 파랑, 마감·취소는 회색입니다.
  (Color, Color) get statusPillColors => switch (status) {
    VoteStatus.voting when votingOpen => (
      MoaColors.accentTint,
      MoaColors.accentText,
    ),
    VoteStatus.confirmed => (MoaColors.accentTint, MoaColors.accentText),
    _ => (MoaColors.fill, MoaColors.textSecondary),
  };

  /// 제목 아래 안내 문구입니다. 없으면 null 입니다. (Figma 투표 중·마감됨·확정됨·취소됨)
  String? subtitleFor({required bool isAdmin}) => switch (status) {
    VoteStatus.voting when votingOpen =>
      isTableScrollable ? '날짜는 옆으로, 시간은 위아래로 넘겨 보세요.' : null,
    VoteStatus.voting => isAdmin ? '투표가 끝났어요. 일정을 확정해 주세요.' : '투표가 끝났어요.',
    VoteStatus.confirmed => '투표로 정한 일정이에요.',
    VoteStatus.canceled => '관리자가 투표를 취소했어요.',
  };

  /// 표의 칸을 보여줄 불투명도입니다.
  /// 구성원이 더 고를 수 없는 마감 뒤에는 흐리게 하되 내가 고른 칸은 그대로 두고, 확정된 뒤에는 모든 칸을 더 흐리게 합니다.
  /// 관리자는 마감 뒤에도 확정해야 해서 흐리게 하지 않습니다. 취소된 투표는 표 전체를 흐리게 하므로([tableOpacity]) 칸은 그대로 둡니다.
  double cellOpacityOf(VoteCandidate candidate, {required bool isAdmin}) =>
      switch (status) {
        VoteStatus.voting when votingOpen => 1,
        VoteStatus.voting => isAdmin || candidate.selectedByMe ? 1 : 0.6,
        VoteStatus.confirmed => 0.4,
        VoteStatus.canceled => 1,
      };

  /// 표를 옆이나 위아래로 넘겨야 하는지. 날짜나 시각 줄이 많을 때입니다.
  bool get isTableScrollable =>
      candidateDates.length > voteFlexDates ||
      candidateTimes.length > voteFlexTimes;

  /// 표 카드 전체의 불투명도. 취소된 투표만 카드째 흐리게 합니다.
  double get tableOpacity => status == VoteStatus.canceled ? 0.4 : 1;

  /// 공유할 때 복사하는 문구입니다.
  String get shareText => '[모아모아] 일정 투표 · $title\n$statusLabel';

  /// 관리자가 확정할 수 있는지. 마감 전에도 확정할 수 있고, 확정·취소된 뒤에는 바꿀 수 없습니다. (API 5-5)
  bool get canConfirm => status == VoteStatus.voting && candidates.isNotEmpty;

  /// 응답하지 않은 인원
  int get unrespondedCount => memberCount - respondedCount;

  /// 예: 7/8명
  String get respondedLabel => '$respondedCount/$memberCount명';

  /// 구성원 화면의 응답 현황. 예: 응답 7/8명
  String get respondedSummaryLabel => '응답 $respondedLabel';

  /// 표의 열: 후보 날짜 (오름차순)
  List<DateTime> get candidateDates =>
      {for (final candidate in candidates) DateUtils.dateOnly(candidate._local)}
          .toList()
        ..sort();

  /// 표의 줄: 하루 중 후보 시각 (오름차순)
  List<Duration> get candidateTimes =>
      {for (final candidate in candidates) candidate._timeOfDay}.toList()
        ..sort();

  /// 표의 칸 하나에 해당하는 후보. 그 날짜·시각에 후보가 없으면 null 입니다.
  VoteCandidate? candidateAt(DateTime date, Duration time) => candidates
      .where((c) => DateUtils.isSameDay(c._local, date) && c._timeOfDay == time)
      .firstOrNull;

  /// 칸 색 단계(0~4). 전체 인원 대비 가능 인원을 4단계로 나누고, 0명이면 0 입니다.
  int heatOf(VoteCandidate candidate) {
    if (memberCount == 0 || candidate.availableCount == 0) return 0;
    return (candidate.availableCount * 4 / memberCount).ceil().clamp(1, 4);
  }

  Color heatColorOf(VoteCandidate candidate) =>
      VoteColors.heat[heatOf(candidate)];

  /// 가장 진한 칸만 흰 글자입니다.
  Color heatTextColorOf(VoteCandidate candidate) =>
      heatOf(candidate) == 4 ? MoaColors.textInverse : MoaColors.textPrimary;

  /// 확정 시트 순서: 가능 인원이 많은 순, 같으면 이른 시간 순
  List<VoteCandidate> get rankedCandidates => [...candidates]
    ..sort((a, b) {
      final byCount = b.availableCount.compareTo(a.availableCount);
      return byCount != 0 ? byCount : a.meetingTime.compareTo(b.meetingTime);
    });
}

extension on VoteCandidate {
  DateTime get _local => meetingTime.toLocal();

  Duration get _timeOfDay =>
      Duration(hours: _local.hour, minutes: _local.minute);
}

/// 표 칸의 "내 선택" 테두리입니다.
extension VoteCandidateDisplayX on VoteCandidate {
  Border? get mineBorder =>
      selectedByMe ? Border.all(color: MoaColors.textPrimary, width: 2) : null;
}

extension VoteResponsesDisplayX on VoteResponses {
  /// 예: 미응답 최민아, 이름 미설정. 모두 응답했으면 null 입니다.
  String? get unrespondedNamesLabel {
    final names = [
      for (final member in members)
        if (!member.responded) member.userName.profileDisplayName,
    ];
    return names.isEmpty ? null : '미응답 ${names.join(', ')}';
  }
}

/// 투표 화면 오류 문구입니다. 서버 문구가 있으면 그대로 보여줍니다.
extension VoteErrorMessageX on Object {
  String get voteErrorMessage => switch (this) {
    final ApiException e => e.userMessage,
    _ => '투표를 불러오지 못했어요',
  };
}
