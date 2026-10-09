import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';
import 'package:moamoa/features/schedule/domain/errors/schedule_validation_error.dart';
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
    if (time == null || !mounted) return null;
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

  Future<void> _pickStart() async {
    final picked = await _pickDateTime(_startAt);
    if (picked != null) setState(() => _startAt = picked);
  }

  Future<void> _pickEnd() async {
    final picked = await _pickDateTime(_endAt ?? _startAt);
    if (picked != null) setState(() => _endAt = picked);
  }

  /// 제출 결과 처리: 성공하면 화면을 닫고, 입력 문제가 아닌 실패는 안내한다.
  void _onSubmitResult(AsyncValue<int?> next) {
    // 오류/로딩 상태도 이전 성공 값을 들고 있을 수 있어서 AsyncData 일 때만 성공으로 본다.
    if (next case AsyncData(value: final _?)) {
      context.pop();
    } else if (next.hasError && next.error is! ScheduleValidationException) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('일정을 만들지 못했어요')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = scheduleCreateProvider(widget.meetingId);
    ref.listen(provider, (_, next) => _onSubmitResult(next));
    final state = ref.watch(provider);
    final error = state.error;

    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: const MoaAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _CreateForm(
                titleController: _title,
                locationController: _location,
                descriptionController: _description,
                startAt: _startAt,
                endAt: _endAt,
                errors: error is ScheduleValidationException
                    ? error.errors
                    : const <ScheduleValidationError>{},
                onPickStart: _pickStart,
                onPickEnd: _pickEnd,
              ),
            ),
            _SubmitButton(onPressed: state.isLoading ? null : _submit),
          ],
        ),
      ),
    );
  }
}

/// 입력 영역: 이름, 시작/종료 일시, 장소, 설명
class _CreateForm extends StatelessWidget {
  const _CreateForm({
    required this.titleController,
    required this.locationController,
    required this.descriptionController,
    required this.startAt,
    required this.endAt,
    required this.errors,
    required this.onPickStart,
    required this.onPickEnd,
  });

  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final DateTime? startAt;
  final DateTime? endAt;
  final Set<ScheduleValidationError> errors;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 18,
        children: [
          Text('일정 만들기', style: MoaText.titleXl),
          _TextFormField(
            label: '일정 이름',
            controller: titleController,
            hint: '일정 이름을 입력해 주세요',
            error: errors.contains(ScheduleValidationError.titleRequired)
                ? '일정 이름을 입력해 주세요.'
                : null,
          ),
          _PickerField(
            label: '시작 일시',
            value: startAt,
            error: errors.contains(ScheduleValidationError.startAtRequired)
                ? '시작 일시를 선택해 주세요.'
                : null,
            onTap: onPickStart,
          ),
          _PickerField(
            label: '종료 일시 (선택)',
            value: endAt,
            error: errors.contains(ScheduleValidationError.endBeforeStart)
                ? '종료 일시는 시작 일시 이후여야 해요.'
                : null,
            onTap: onPickEnd,
          ),
          _TextFormField(
            label: '장소 (선택)',
            controller: locationController,
            hint: '장소를 입력해 주세요',
            icon: 'map_pin_field',
          ),
          _TextFormField(
            label: '설명 (선택)',
            controller: descriptionController,
            hint: '일정 설명을 입력해 주세요',
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}

/// 라벨 + 글자 입력 상자
class _TextFormField extends StatelessWidget {
  const _TextFormField({
    required this.label,
    required this.controller,
    required this.hint,
    this.icon,
    this.maxLines = 1,
    this.error,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final String? icon;
  final int maxLines;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return _Field(
      label,
      error: error,
      child: _InputBox(
        icon: icon,
        child: _TextInput(
          controller: controller,
          hint: hint,
          maxLines: maxLines,
        ),
      ),
    );
  }
}

/// 라벨 + 날짜/시간 선택 상자
class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.onTap,
    this.error,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return _Field(
      label,
      error: error,
      child: _PickerBox(value, '날짜와 시간을 선택해 주세요', onTap),
    );
  }
}

/// 하단 "일정 만들기" 버튼. [onPressed] 가 null 이면(제출 중) 비활성화된다.
class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: FilledButton(
          onPressed: onPressed,
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

/// 입력 상자 안의 글자 입력창
class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
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
