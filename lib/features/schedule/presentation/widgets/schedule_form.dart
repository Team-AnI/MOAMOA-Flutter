import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

import '../schedule_format.dart';

/// 일정 만들기/수정 화면이 함께 쓰는 입력 폼입니다. 입력 → 제출 순서로 동작합니다.
///
/// - 입력: 이름, 시작 일시(필수), 종료 일시(선택), 장소(선택), 설명(선택)
/// - 제출: 아래 버튼. 이름이나 시작 일시가 비어 있거나 [isSubmitting] 이면 비활성화됩니다.
/// - [heading]: 입력 영역 맨 위 제목. [submitLabel]: 하단 버튼 글자
/// - [initial]: 수정할 일정. 있으면 그 값으로 채워서 시작합니다.
/// - [onSubmit]: 버튼을 누르면 현재 입력값과 함께 호출됩니다.
class ScheduleForm extends StatefulWidget {
  const ScheduleForm({
    super.key,
    required this.heading,
    required this.submitLabel,
    required this.isSubmitting,
    required this.onSubmit,
    this.initial,
  });

  final String heading;
  final String submitLabel;
  final bool isSubmitting;
  final Schedule? initial;
  final void Function({
    required String title,
    required String description,
    required DateTime startAt,
    DateTime? endAt,
    required String location,
  })
  onSubmit;

  @override
  State<ScheduleForm> createState() => _ScheduleFormState();
}

/// 글자 입력 컨트롤러 3개와 선택한 시작/종료 일시를 들고 있습니다.
class _ScheduleFormState extends State<ScheduleForm> {
  late final _title = TextEditingController(text: widget.initial?.title);
  late final _location = TextEditingController(text: widget.initial?.location);
  late final _description = TextEditingController(
    text: widget.initial?.description,
  );
  late DateTime? _startAt = widget.initial?.startAt.toLocal();
  late DateTime? _endAt = widget.initial?.endAt?.toLocal();

  @override
  void initState() {
    super.initState();
    _title.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _title.dispose();
    _location.dispose();
    _description.dispose();
    super.dispose();
  }

  /// 날짜를 고른 뒤 이어서 시간을 골라 하나의 일시로 줍니다.
  /// 둘 중 하나라도 취소하거나, 고르는 동안 화면이 닫히면 null 을 돌려줍니다.
  /// [initial] 은 선택창이 처음 보여줄 값입니다(없으면 지금).
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

  /// 현재 입력값으로 제출합니다.
  void _submit() {
    FocusScope.of(context).unfocus();
    widget.onSubmit(
      title: _title.text,
      description: _description.text,
      startAt: _startAt!,
      endAt: _endAt,
      location: _location.text,
    );
  }

  /// 시작 일시를 고른다. 취소하면 기존 값을 유지합니다
  Future<void> _pickStart() async {
    final picked = await _pickDateTime(_startAt);
    if (picked != null) setState(() => _startAt = picked);
  }

  /// 종료 일시를 고릅니다. 시작 일시가 있으면 그 날짜를 처음 위치로 보여줍니다. 취소하면 기존 값을 유지합니다.
  Future<void> _pickEnd() async {
    final picked = await _pickDateTime(_endAt ?? _startAt);
    if (picked != null) setState(() => _endAt = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _FormFields(
            heading: widget.heading,
            titleController: _title,
            locationController: _location,
            descriptionController: _description,
            startAt: _startAt,
            endAt: _endAt,
            onPickStart: _pickStart,
            onPickEnd: _pickEnd,
          ),
        ),
        _SubmitButton(
          label: widget.submitLabel,
          onPressed:
              widget.isSubmitting ||
                  _title.text.trim().isEmpty ||
                  _startAt == null
              ? null
              : _submit,
        ),
      ],
    );
  }
}

/// 입력 영역: 이름, 시작/종료 일시, 장소, 설명. 길어질 수 있어서 스크롤됩니다.
///
/// 값은 직접 들고 있지 않고, 글자 입력은 컨트롤러로, 일시는 [startAt]/[endAt] 로 받아 보여줍니다.
/// 일시 칸을 누르면 [onPickStart]/[onPickEnd] 가 호출됩니다.
class _FormFields extends StatelessWidget {
  const _FormFields({
    required this.heading,
    required this.titleController,
    required this.locationController,
    required this.descriptionController,
    required this.startAt,
    required this.endAt,
    required this.onPickStart,
    required this.onPickEnd,
  });

  final String heading;
  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final DateTime? startAt;
  final DateTime? endAt;
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
          Text(heading, style: MoaText.titleXl),
          _TextFormField(
            label: '일정 이름',
            controller: titleController,
            hint: '일정 이름을 입력해 주세요',
          ),
          _PickerField(label: '시작 일시', value: startAt, onTap: onPickStart),
          _PickerField(label: '종료 일시 (선택)', value: endAt, onTap: onPickEnd),
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

/// 라벨과 글자 입력 상자입니다.
class _TextFormField extends StatelessWidget {
  const _TextFormField({
    required this.label,
    required this.controller,
    required this.hint,
    this.icon,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final String? icon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return _Field(
      label: label,
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

/// 라벨과 날짜/시간 선택 상자입니다.
class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _Field(
      label: label,
      child: _PickerBox(
        value: value,
        placeholder: '날짜와 시간을 선택해 주세요',
        onTap: onTap,
      ),
    );
  }
}

/// 하단 제출 버튼입니다. [onPressed] 가 null 이면 비활성화됩니다.
/// (이름이나 시작 일시가 비어 있거나 제출 중일 때)
class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.label, required this.onPressed});

  final String label;
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
          child: Text(label),
        ),
      ),
    );
  }
}

/// 라벨과 입력 상자입니다.
class _Field extends StatelessWidget {
  const _Field({required this.label, required this.child});

  final String label;
  final Widget child;

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
      ],
    );
  }
}

/// 회색 둥근 입력 상자입니다. (Figma "Input")
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

/// 눌러서 날짜/시간을 고르는 입력 상자입니다.
class _PickerBox extends StatelessWidget {
  const _PickerBox({
    required this.value,
    required this.placeholder,
    required this.onTap,
  });

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

/// 입력 상자 안의 글자 입력창입니다.
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
