import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 일정 상태 라벨입니다.
///
/// - 투표 중([isVoting])이면 파란 "투표 중"을 보여줍니다.
/// - 그 밖에는 시작 일시가 지났으면([isPast]) "지난 일정", 아니면 "확정"을 보여줍니다.
class ScheduleStatusPill extends StatelessWidget {
  const ScheduleStatusPill({
    super.key,
    required this.isPast,
    this.isVoting = false,
  });

  final bool isPast;
  final bool isVoting;

  String get _label => switch ((isVoting, isPast)) {
    (true, _) => '투표 중',
    (false, true) => '지난 일정',
    (false, false) => '확정',
  };

  Color get _background => isVoting ? MoaColors.accentTint : MoaColors.raised;

  Color get _foreground =>
      isVoting ? MoaColors.accentText : MoaColors.textSecondary;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _background,
        borderRadius: const BorderRadius.all(Radius.circular(9999)),
      ),
      child: Text(
        _label,
        style: MoaText.captionStrong.copyWith(color: _foreground),
      ),
    );
  }
}
