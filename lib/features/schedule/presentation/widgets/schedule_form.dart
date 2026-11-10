import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';

import '../schedule_format.dart';

/// 일정 만들기/수정 화면이 함께 쓰는 입력 폼입니다. 입력 → 제출 순서로 동작합니다.
///
/// - 입력: 이름, 시작 일시(필수), 종료 일시(선택), 장소(선택), 설명(선택)
/// - 제출: 아래 버튼. 이름이나 시작 일시가 비어 있거나 [isSubmitting] 이면 비활성화됩니다.
/// - [heading]: 입력 영역 맨 위 제목. 없으면 그리지 않습니다. [submitLabel]: 하단 버튼 글자
/// - [initial]: 수정할 일정. 수정 폼은 이 값으로 채워서 시작합니다.
class ScheduleForm extends StatefulWidget {
  /// 일정 만들기 폼입니다. 버튼을 누르면 [onSubmit] 이 모든 입력값과 함께 호출됩니다.
  const ScheduleForm.create({
    super.key,
    this.heading,
    required this.submitLabel,
    required this.isSubmitting,
    required void Function({
      required String title,
      required String description,
      required DateTime startAt,
      DateTime? endAt,
      required String location,
    })
    onSubmit,
  }) : _onCreate = onSubmit,
       _onEditSubmit = null,
       _onTitleChanged = null,
       _onDescriptionChanged = null,
       _onStartAtChanged = null,
       _onEndAtChanged = null,
       _onLocationChanged = null,
       initial = null;

  /// 일정 수정 폼입니다. 바뀐 값이 없으면 버튼이 비활성화됩니다.
  ///
  /// 입력이 바뀔 때마다 해당 속성의 콜백(예: [onTitleChanged])을 바뀐 값으로 호출합니다.
  /// 원래 값과 같아지면 null 로 호출합니다. 버튼을 누르면 [onSubmit] 이 호출됩니다.
  const ScheduleForm.edit({
    super.key,
    required this.submitLabel,
    required this.isSubmitting,
    required Schedule this.initial,
    required ValueChanged<String?> onTitleChanged,
    required ValueChanged<String?> onDescriptionChanged,
    required ValueChanged<DateTime?> onStartAtChanged,
    required ValueChanged<DateTime?> onEndAtChanged,
    required ValueChanged<String?> onLocationChanged,
    required VoidCallback onSubmit,
  }) : _onTitleChanged = onTitleChanged,
       _onDescriptionChanged = onDescriptionChanged,
       _onStartAtChanged = onStartAtChanged,
       _onEndAtChanged = onEndAtChanged,
       _onLocationChanged = onLocationChanged,
       _onEditSubmit = onSubmit,
       _onCreate = null,
       heading = null;

  final String? heading;
  final String submitLabel;
  final bool isSubmitting;
  final Schedule? initial;
  final void Function({
    required String title,
    required String description,
    required DateTime startAt,
    DateTime? endAt,
    required String location,
  })?
  _onCreate;
  final ValueChanged<String?>? _onTitleChanged;
  final ValueChanged<String?>? _onDescriptionChanged;
  final ValueChanged<DateTime?>? _onStartAtChanged;
  final ValueChanged<DateTime?>? _onEndAtChanged;
  final ValueChanged<String?>? _onLocationChanged;
  final VoidCallback? _onEditSubmit;

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

  /// 수정 폼에서 바뀌었는지 판단하는 값들입니다. 바뀌지 않았으면 null 입니다.
  String? get _changedTitle => _changedText(_title, widget.initial?.title);
  String? get _changedDescription =>
      _changedText(_description, widget.initial?.description);
  String? get _changedLocation =>
      _changedText(_location, widget.initial?.location);
  DateTime? get _changedStartAt =>
      _changedTime(_startAt, widget.initial?.startAt);
  DateTime? get _changedEndAt => _changedTime(_endAt, widget.initial?.endAt);

  /// 만들기 폼은 항상 true, 수정 폼은 바뀐 값이 하나라도 있을 때 true 입니다.
  bool get _hasChanges =>
      widget.initial == null ||
      _changedTitle != null ||
      _changedDescription != null ||
      _changedLocation != null ||
      _changedStartAt != null ||
      _changedEndAt != null;

  /// 이름과 시작 일시가 있고, 바뀐 값이 있고, 제출 중이 아닐 때만 제출할 수 있습니다.
  bool get _canSubmit =>
      !widget.isSubmitting &&
      _title.text.trim().isNotEmpty &&
      _startAt != null &&
      _hasChanges;

  @override
  void initState() {
    super.initState();
    _title.addListener(
      () => _onTextChanged(widget._onTitleChanged, _changedTitle),
    );
    _location.addListener(
      () => _onTextChanged(widget._onLocationChanged, _changedLocation),
    );
    _description.addListener(
      () => _onTextChanged(widget._onDescriptionChanged, _changedDescription),
    );
  }

  /// 입력이 바뀌면 제출 버튼 상태를 다시 계산하고, 수정 폼이면 [onChanged] 로 바뀐 값을 알립니다.
  void _onTextChanged(ValueChanged<String?>? onChanged, String? changed) {
    setState(() {});
    onChanged?.call(changed);
  }

  /// [controller] 의 앞뒤 공백을 지운 값이 [original] 과 다를 때만 돌려줍니다.
  String? _changedText(TextEditingController controller, String? original) {
    final trimmed = controller.text.trim();
    return trimmed == original ? null : trimmed;
  }

  /// [value] 가 [original] 과 다른 순간일 때만 돌려줍니다.
  /// 서버 응답은 UTC, 입력 폼은 로컬 시각이라 `==` 대신 같은 순간인지로 비교합니다.
  /// 종료 일시를 비우는 수정은 아직 지원하지 않아서 [value] 가 null 이면 바꾸지 않습니다.
  DateTime? _changedTime(DateTime? value, DateTime? original) {
    if (value == null) return null;
    if (original != null && value.isAtSameMomentAs(original)) return null;
    return value;
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
    final earliest = DateTime(now.year - 1);
    final latest = DateTime(now.year + 5);
    // 선택창은 처음 보여줄 날짜가 선택 범위 밖이면 오류가 납니다.
    // 오래 지난(또는 먼 미래의) 일정을 수정할 때는 그 날짜까지 범위를 넓힙니다.
    final initialDay = initial == null ? null : DateUtils.dateOnly(initial);
    final date = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: initialDay != null && initialDay.isBefore(earliest)
          ? initialDay
          : earliest,
      lastDate: initialDay != null && initialDay.isAfter(latest)
          ? initialDay
          : latest,
    );
    if (date == null || !mounted) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial ?? now),
    );
    if (time == null || !mounted) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  /// 제출합니다. 만들기는 모든 입력값을 넘기고, 수정은 이미 알린 바뀐 값으로 저장하도록 알립니다.
  void _submit() {
    FocusScope.of(context).unfocus();
    widget._onCreate?.call(
      title: _title.text,
      description: _description.text,
      startAt: _startAt!,
      endAt: _endAt,
      location: _location.text,
    );
    widget._onEditSubmit?.call();
  }

  /// 시작 일시를 고른다. 취소하면 기존 값을 유지합니다
  Future<void> _pickStart() async {
    final picked = await _pickDateTime(_startAt);
    if (picked == null) return;
    setState(() => _startAt = picked);
    widget._onStartAtChanged?.call(_changedStartAt);
  }

  /// 종료 일시를 고릅니다. 시작 일시가 있으면 그 날짜를 처음 위치로 보여줍니다. 취소하면 기존 값을 유지합니다.
  Future<void> _pickEnd() async {
    final picked = await _pickDateTime(_endAt ?? _startAt);
    if (picked == null) return;
    setState(() => _endAt = picked);
    widget._onEndAtChanged?.call(_changedEndAt);
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
          onPressed: _canSubmit ? _submit : null,
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
    this.heading,
    required this.titleController,
    required this.locationController,
    required this.descriptionController,
    required this.startAt,
    required this.endAt,
    required this.onPickStart,
    required this.onPickEnd,
  });

  final String? heading;
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
      // 제목이 없으면(상단 바에 제목이 있는 화면) 첫 입력칸이 상단 바 바로 아래에서 시작합니다.
      padding: EdgeInsets.fromLTRB(20, heading == null ? 8 : 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 18,
        children: [
          if (heading != null) Text(heading!, style: MoaText.titleXl),
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
/// (이름이나 시작 일시가 비어 있거나, 수정 폼에서 바뀐 값이 없거나, 제출 중일 때)
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
