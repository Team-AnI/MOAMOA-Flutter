import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_sheet_grabber.dart';

import '../vote_format.dart';
import 'vote_primary_button.dart';

/// 후보 날짜를 여러 개 고르는 시트입니다. (Figma "[P0] 후보 날짜 선택 시트")
///
/// 날짜를 누르면 고르거나 빼고, 아래 칩을 눌러도 뺄 수 있습니다.
/// 완료를 누르면 고른 날짜를 오름차순으로 돌려줍니다. 그냥 닫으면 null 입니다.
class VoteDateSheet extends StatefulWidget {
  const VoteDateSheet({super.key, required this.initialDates});

  /// 이미 고른 날짜(시각 없음)
  final List<DateTime> initialDates;

  @override
  State<VoteDateSheet> createState() => _VoteDateSheetState();
}

/// 고른 날짜와 보고 있는 달을 들고 있습니다.
class _VoteDateSheetState extends State<VoteDateSheet> {
  late final Set<DateTime> _picked = {...widget.initialDates};

  /// 보고 있는 달(1일). 고른 날짜가 있으면 첫 날짜의 달, 없으면 이번 달입니다.
  late DateTime _month = _monthOf(
    widget.initialDates.firstOrNull ?? DateTime.now(),
  );

  static DateTime _monthOf(DateTime date) => DateTime(date.year, date.month);

  List<DateTime> get _sortedPicked => _picked.toList()..sort();

  String get _doneLabel =>
      _picked.isEmpty ? '날짜를 골라 주세요' : '${_picked.length}일 선택 완료';

  VoidCallback? get _onDone => _picked.isEmpty ? null : _done;

  void _done() => Navigator.pop(context, _sortedPicked);

  void _toggle(DateTime date) => setState(() {
    if (!_picked.remove(date)) _picked.add(date);
  });

  void _remove(DateTime date) => setState(() => _picked.remove(date));

  void _moveMonth(int offset) =>
      setState(() => _month = DateTime(_month.year, _month.month + offset));

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
            _Head(count: _picked.length),
            _MonthHeader(month: _month, onMove: _moveMonth),
            _MonthGrid(month: _month, picked: _picked, onTap: _toggle),
            if (_picked.isNotEmpty)
              _PickedChips(dates: _sortedPicked, onRemove: _remove),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: VotePrimaryButton(label: _doneLabel, onPressed: _onDone),
            ),
          ],
        ),
      ),
    );
  }
}

/// 시트 제목, 안내 문구, 고른 날짜 수입니다.
class _Head extends StatelessWidget {
  const _Head({required this.count});

  final int count;

  String? get _countLabel => count == 0 ? null : '$count일 선택';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text('후보 날짜', style: MoaText.titleM),
                Text(
                  '투표할 날짜를 모두 눌러 주세요',
                  style: MoaText.sub.copyWith(color: MoaColors.textSecondary),
                ),
              ],
            ),
          ),
          if (_countLabel case final label?)
            Text(
              label,
              style: MoaText.subStrong.copyWith(color: MoaColors.accentText),
            ),
        ],
      ),
    );
  }
}

/// 이전 달 / 연월 / 다음 달입니다. 화살표를 누르면 [onMove] 에 -1 또는 1 을 넘깁니다.
class _MonthHeader extends StatelessWidget {
  const _MonthHeader({required this.month, required this.onMove});

  final DateTime month;
  final ValueChanged<int> onMove;

  static final _buttonStyle = IconButton.styleFrom(
    backgroundColor: MoaColors.fill,
    fixedSize: const Size.square(34),
    minimumSize: const Size.square(34),
    padding: EdgeInsets.zero,
    // 기본 터치 영역(48)만큼 안쪽으로 밀리지 않게 Figma 크기(34) 그대로 둡니다.
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            tooltip: '이전 달',
            style: _buttonStyle,
            onPressed: () => onMove(-1),
            icon: SvgPicture.asset('assets/icons/caret_left_calendar.svg'),
          ),
          Text(month.monthLabel, style: MoaText.titleS),
          IconButton(
            tooltip: '다음 달',
            style: _buttonStyle,
            onPressed: () => onMove(1),
            icon: SvgPicture.asset('assets/icons/caret_right_calendar.svg'),
          ),
        ],
      ),
    );
  }
}

/// 요일 줄과 날짜 칸입니다. 고른 날짜는 검은 원으로 표시합니다. 요일은 일요일부터 시작합니다.
class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.month,
    required this.picked,
    required this.onTap,
  });

  final DateTime month;
  final Set<DateTime> picked;
  final ValueChanged<DateTime> onTap;

  static const _weekdays = ['일', '월', '화', '수', '목', '금', '토'];

  /// 1일 앞의 빈 칸(null) + 1일~말일. 마지막 줄은 빈 칸으로 7칸을 채웁니다.
  List<DateTime?> get _cells {
    final leading = month.weekday % 7; // 일요일 시작
    final days = DateUtils.getDaysInMonth(month.year, month.month);
    final cells = <DateTime?>[
      ...List.filled(leading, null),
      for (var day = 1; day <= days; day++)
        DateTime(month.year, month.month, day),
    ];
    while (cells.length % 7 != 0) {
      cells.add(null);
    }
    return cells;
  }

  /// 고른 날짜는 검은 원에 흰 글자로 보여줍니다.
  Color? _circleColorOf(DateTime date) =>
      picked.contains(date) ? MoaColors.accent : null;

  TextStyle _textStyleOf(DateTime date) => picked.contains(date)
      ? MoaText.bodyStrong.copyWith(color: MoaColors.textInverse)
      : MoaText.body;

  @override
  Widget build(BuildContext context) {
    final cells = _cells;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        spacing: 2,
        children: [
          Row(
            children: [
              for (final weekday in _weekdays)
                Expanded(
                  child: Text(
                    weekday,
                    textAlign: TextAlign.center,
                    style: MoaText.captionStrong.copyWith(
                      color: MoaColors.textTertiary,
                    ),
                  ),
                ),
            ],
          ),
          // 7칸씩 끊어서 한 주(한 줄)로 그립니다.
          for (var i = 0; i < cells.length; i += 7)
            Row(
              children: [
                for (final date in cells.sublist(i, i + 7))
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      // 날짜 한 칸. 1일 앞과 말일 뒤는 빈 칸입니다.
                      child: date == null
                          ? null
                          : Center(
                              child: GestureDetector(
                                onTap: () => onTap(date),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _circleColorOf(date),
                                  ),
                                  child: Text(
                                    '${date.day}',
                                    style: _textStyleOf(date),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

/// 고른 날짜 칩입니다. 칩을 누르면 [onRemove] 로 그 날짜를 뺍니다. 많으면 옆으로 넘깁니다.
class _PickedChips extends StatelessWidget {
  const _PickedChips({required this.dates, required this.onRemove});

  final List<DateTime> dates;
  final ValueChanged<DateTime> onRemove;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        spacing: 8,
        children: [
          for (final date in dates)
            GestureDetector(
              onTap: () => onRemove(date),
              child: Container(
                height: 32,
                padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
                decoration: const BoxDecoration(
                  color: MoaColors.fill,
                  borderRadius: BorderRadius.all(Radius.circular(9999)),
                ),
                child: Row(
                  spacing: 4,
                  children: [
                    Text(date.shortDateLabel, style: MoaText.captionStrong),
                    SvgPicture.asset('assets/icons/x_chip.svg'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
