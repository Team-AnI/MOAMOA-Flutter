import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_back_bar.dart';
import 'package:moamoa/features/schedule/domain/errors/schedule_validation_exception.dart';

import '../providers/schedule_providers.dart';
import '../schedule_format.dart';

/// 일정 만들기 (관리자)
class ScheduleCreatePage extends ConsumerStatefulWidget {
  const ScheduleCreatePage({super.key, required this.meetingId});

  final int meetingId;

  @override
  ConsumerState<ScheduleCreatePage> createState() => _ScheduleCreatePageState();
}

class _ScheduleCreatePageState extends ConsumerState<ScheduleCreatePage> {
  final _title = TextEditingController();
  final _location = TextEditingController();
  final _description = TextEditingController();
  DateTime? _startAt;
  DateTime? _endAt;

  @override
  void dispose() {
    _title.dispose();
    _location.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<DateTime?> _pickDateTime(DateTime? initial) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );
    if (date == null || !mounted) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial ?? now),
    );
    if (time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    ref
        .read(scheduleCreateProvider(widget.meetingId).notifier)
        .submit(
          title: _title.text,
          description: _description.text,
          startAt: _startAt,
          endAt: _endAt,
          location: _location.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final provider = scheduleCreateProvider(widget.meetingId);
    ref.listen(provider, (_, next) {
      // 오류/로딩 상태도 이전 성공 값을 들고 있을 수 있어서 AsyncData 일 때만 성공으로 본다.
      if (next case AsyncData(value: final _?)) {
        context.pop();
      } else if (next.hasError && next.error is! ScheduleValidationException) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('일정을 만들지 못했어요')));
      }
    });
    final state = ref.watch(provider);
    final error = state.error;
    final errors = error is ScheduleValidationException
        ? error.errors
        : const <ScheduleValidationError>{};

    return Scaffold(
      backgroundColor: MoaColors.page,
      body: SafeArea(
        child: Column(
          children: [
            const MoaBackBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 18,
                  children: [
                    Text('일정 만들기', style: MoaText.titleXl),
                    _Field(
                      '일정 이름',
                      error:
                          errors.contains(ScheduleValidationError.titleRequired)
                          ? '일정 이름을 입력해 주세요.'
                          : null,
                      child: _InputBox(
                        child: _textField(_title, '일정 이름을 입력해 주세요'),
                      ),
                    ),
                    _Field(
                      '시작 일시',
                      error:
                          errors.contains(
                            ScheduleValidationError.startAtRequired,
                          )
                          ? '시작 일시를 선택해 주세요.'
                          : null,
                      child: _PickerBox(_startAt, '날짜와 시간을 선택해 주세요', () async {
                        final picked = await _pickDateTime(_startAt);
                        if (picked != null) setState(() => _startAt = picked);
                      }),
                    ),
                    _Field(
                      '종료 일시 (선택)',
                      error:
                          errors.contains(
                            ScheduleValidationError.endBeforeStart,
                          )
                          ? '종료 일시는 시작 일시 이후여야 해요.'
                          : null,
                      child: _PickerBox(_endAt, '날짜와 시간을 선택해 주세요', () async {
                        final picked = await _pickDateTime(_endAt ?? _startAt);
                        if (picked != null) setState(() => _endAt = picked);
                      }),
                    ),
                    _Field(
                      '장소 (선택)',
                      child: _InputBox(
                        icon: 'map_pin_field',
                        child: _textField(_location, '장소를 입력해 주세요'),
                      ),
                    ),
                    _Field(
                      '설명 (선택)',
                      child: _InputBox(
                        child: _textField(
                          _description,
                          '일정 설명을 입력해 주세요',
                          maxLines: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: state.isLoading ? null : _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: MoaColors.accent,
                    foregroundColor: MoaColors.textInverse,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    textStyle: MoaText.button,
                  ),
                  child: const Text('일정 만들기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      minLines: 1,
      style: MoaText.body,
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        hintText: hint,
        hintStyle: MoaText.body.copyWith(color: MoaColors.textTertiary),
      ),
    );
  }
}

/// 라벨 + 입력 상자 + (있다면) 오류 문구
class _Field extends StatelessWidget {
  const _Field(this.label, {required this.child, this.error});

  final String label;
  final Widget child;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            label,
            style: MoaText.subStrong.copyWith(color: MoaColors.textSecondary),
          ),
        ),
        child,
        if (error != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              error!,
              style: MoaText.caption.copyWith(color: MoaColors.error),
            ),
          ),
      ],
    );
  }
}

/// 회색 둥근 입력 상자 (Figma "Input")
class _InputBox extends StatelessWidget {
  const _InputBox({required this.child, this.icon, this.showCaret = false});

  final Widget child;
  final String? icon;
  final bool showCaret;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 54),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: const BoxDecoration(
        color: MoaColors.fill,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        spacing: 10,
        children: [
          if (icon != null) SvgPicture.asset('assets/icons/$icon.svg'),
          Expanded(child: child),
          if (showCaret) SvgPicture.asset('assets/icons/caret_right.svg'),
        ],
      ),
    );
  }
}

/// 날짜/시간을 눌러서 고르는 입력 상자
class _PickerBox extends StatelessWidget {
  const _PickerBox(this.value, this.placeholder, this.onTap);

  final DateTime? value;
  final String placeholder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: _InputBox(
        icon: 'clock_field',
        showCaret: true,
        child: Text(
          value?.fieldLabel ?? placeholder,
          style: MoaText.body.copyWith(
            color: value == null
                ? MoaColors.textTertiary
                : MoaColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
