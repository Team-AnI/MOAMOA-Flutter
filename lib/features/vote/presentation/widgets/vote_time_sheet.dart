import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_sheet_grabber.dart';

import '../viewmodels/vote_slot_interval.dart';
import '../viewmodels/vote_time_range.dart';
import '../vote_format.dart';
import 'vote_colors.dart';
import 'vote_primary_button.dart';

/// 하루 중 후보 시간 범위와 간격을 고르는 시트입니다. (Figma "[P0] 후보 시간 설정 시트")
///
/// 시작·종료는 30분 단위 휠로 고릅니다. 종료가 시작보다 늦지 않으면 적용할 수 없습니다.
/// 적용을 누르면 고른 범위를 돌려주고, 그냥 닫으면 null 입니다.
class VoteTimeSheet extends StatefulWidget {
  const VoteTimeSheet({super.key, required this.initialRange});

  final VoteTimeRange initialRange;

  @override
  State<VoteTimeSheet> createState() => _VoteTimeSheetState();
}

/// 고르는 중인 범위를 들고 있습니다.
class _VoteTimeSheetState extends State<VoteTimeSheet> {
  late VoteTimeRange _range = widget.initialRange;

  VoidCallback? get _onApply => _range.isValid ? _apply : null;

  void _apply() => Navigator.pop(context, _range);

  void _changeStart(Duration start) =>
      setState(() => _range = _range.copyWith(start: start));

  void _changeEnd(Duration end) =>
      setState(() => _range = _range.copyWith(end: end));

  void _changeInterval(VoteSlotInterval interval) =>
      setState(() => _range = _range.copyWith(interval: interval));

  /// 휠 뒤의 선택 띠. 범위가 잘못됐으면 붉게 보여줍니다.
  Color get _bandColor =>
      _range.isValid ? MoaColors.fill : VoteColors.alertTint;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MoaSheetGrabber(),
            const _Head(),
            // 시작·종료 휠. 뒤의 띠가 가운데(선택된) 줄을 표시하므로 라벨(24) + 위 두 줄(88) 아래에 둡니다.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Positioned(
                    top: 112,
                    left: 0,
                    right: 0,
                    height: 44,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _bandColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _TimeWheel(
                          label: '시작',
                          value: _range.start,
                          onChanged: _changeStart,
                        ),
                      ),
                      // 시작과 종료 사이 "~". 라벨(24) 아래, 휠 가운데 줄 높이에 맞춥니다.
                      SizedBox(
                        width: 33,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Text(
                            '~',
                            textAlign: TextAlign.center,
                            style: MoaText.titleM.copyWith(
                              color: MoaColors.textTertiary,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _TimeWheel(
                          label: '종료',
                          value: _range.end,
                          invalid: !_range.isValid,
                          onChanged: _changeEnd,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: _IntervalSelector(
                selected: _range.interval,
                onChanged: _changeInterval,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 14, 24, 0),
              child: _Summary(range: _range),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: VotePrimaryButton(label: '적용', onPressed: _onApply),
            ),
          ],
        ),
      ),
    );
  }
}

/// 시트 제목과 안내 문구입니다.
class _Head extends StatelessWidget {
  const _Head();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text('후보 시간', style: MoaText.titleM),
          Text(
            '위아래로 끌어서 시작과 종료 시간을 맞춰요',
            style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

/// 라벨과 30분 단위 시각 휠입니다. 가운데 줄이 [value] 이고, 멀어질수록 흐려집니다.
/// [invalid] 이면 가운데 시각을 빨갛게 보여줍니다.
class _TimeWheel extends StatefulWidget {
  const _TimeWheel({
    required this.label,
    required this.value,
    required this.onChanged,
    this.invalid = false,
  });

  final String label;
  final Duration value;
  final ValueChanged<Duration> onChanged;
  final bool invalid;

  @override
  State<_TimeWheel> createState() => _TimeWheelState();
}

/// 휠 위치를 옮기는 컨트롤러를 들고 있습니다.
class _TimeWheelState extends State<_TimeWheel> {
  /// 0:00 부터 23:30 까지 30분 간격
  static final _times = [
    for (var minutes = 0; minutes < 24 * 60; minutes += 30)
      Duration(minutes: minutes),
  ];

  late final _controller = FixedExtentScrollController(initialItem: _selected);

  /// 휠이 가리킬 칸. 30분 간격 목록에 없는 값이 들어와도 오류 없이 맨 위(0:00)에 둡니다.
  int get _selected {
    final index = _times.indexOf(widget.value);
    return index < 0 ? 0 : index;
  }

  Color get _selectedColor =>
      widget.invalid ? VoteColors.alert : MoaColors.textPrimary;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 가운데 줄은 크게, 바로 옆은 흐리게, 그 밖은 더 흐리게 보여줍니다.
  TextStyle _styleOf(int index) => switch ((index - _selected).abs()) {
    0 => MoaText.titleL.copyWith(color: _selectedColor),
    1 => MoaText.body.copyWith(color: MoaColors.textTertiary),
    _ => MoaText.sub.copyWith(color: VoteColors.textDisabled),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 24,
          child: Center(
            child: Text(
              widget.label,
              style: MoaText.captionStrong.copyWith(
                color: MoaColors.textSecondary,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListWheelScrollView.useDelegate(
            controller: _controller,
            itemExtent: 44,
            diameterRatio: 100,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) => widget.onChanged(_times[index]),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: _times.length,
              builder: (context, index) => Center(
                child: Text(_times[index].hhmm, style: _styleOf(index)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// "투표 간격" 라벨과 30분 / 1시간 선택 토글입니다.
class _IntervalSelector extends StatelessWidget {
  const _IntervalSelector({required this.selected, required this.onChanged});

  final VoteSlotInterval selected;
  final ValueChanged<VoteSlotInterval> onChanged;

  static const _selectedDecoration = BoxDecoration(
    color: MoaColors.raised,
    borderRadius: BorderRadius.all(Radius.circular(9999)),
    boxShadow: [
      BoxShadow(color: Color(0x14000000), offset: Offset(0, 2), blurRadius: 4),
    ],
  );

  /// 고른 칸은 흰 바탕에 그림자를 띄웁니다.
  BoxDecoration? _decorationOf(VoteSlotInterval interval) =>
      interval == selected ? _selectedDecoration : null;

  TextStyle _textStyleOf(VoteSlotInterval interval) => interval == selected
      ? MoaText.bodyStrong
      : MoaText.body.copyWith(color: MoaColors.textSecondary);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            '투표 간격',
            style: MoaText.subStrong.copyWith(color: MoaColors.textSecondary),
          ),
        ),
        Container(
          height: 44,
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: MoaColors.fill,
            borderRadius: BorderRadius.all(Radius.circular(9999)),
          ),
          child: Row(
            spacing: 4,
            children: [
              // 간격 한 칸
              for (final interval in VoteSlotInterval.values)
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onChanged(interval),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: _decorationOf(interval),
                      child: Text(
                        interval.label,
                        style: _textStyleOf(interval),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 몇 칸으로 투표하는지 알려줍니다. 범위가 잘못됐으면 오류 문구를 보여줍니다.
class _Summary extends StatelessWidget {
  const _Summary({required this.range});

  final VoteTimeRange range;

  @override
  Widget build(BuildContext context) {
    if (!range.isValid) {
      return Row(
        spacing: 6,
        children: [
          SvgPicture.asset('assets/icons/warning_circle.svg'),
          Text(
            '종료 시간은 시작 시간보다 늦어야 해요',
            style: MoaText.caption.copyWith(color: VoteColors.alert),
          ),
        ],
      );
    }
    return Row(
      spacing: 8,
      children: [
        SvgPicture.asset('assets/icons/info.svg'),
        Expanded(
          child: Text(
            range.summary,
            style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
