import 'package:flutter/material.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/utils/profile_name.dart';

import '../domain/entities/vote.dart';
import '../domain/entities/vote_candidate.dart';
import '../domain/entities/vote_responses.dart';
import '../domain/entities/vote_status.dart';
import 'widgets/vote_colors.dart';

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
