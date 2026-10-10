import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_app_bar.dart';

import '../providers/schedule_providers.dart';
import '../schedule_format.dart';
import '../viewmodels/schedule_create_state.dart';
import '../viewmodels/schedule_create_status.dart';

/// 일정 만들기 화면 (관리자). 입력 → 제출 → 결과 순서로 동작합니다.
///
/// - 입력: 이름, 시작 일시(필수), 종료 일시(선택), 장소(선택), 설명(선택)
/// - 제출: 아래 버튼. 제출 중에는 버튼이 비활성화되어 중복 제출이 막힙니다.
/// - 결과: 성공하면 화면을 닫고(목록은 ViewModel 이 새로 불러옵니다), 입력이 잘못됐으면 해당 입력 아래에
///   문구를 보여주며, 그 밖의 실패는 하단 안내(SnackBar)로 알립니다.
///
/// [meetingId] 는 일정을 만들 모임입니다. 제출 상태는 [scheduleCreateProvider] 가 관리합니다.
class ScheduleCreatePage extends ConsumerStatefulWidget {
  const ScheduleCreatePage({super.key, required this.meetingId});

  final int meetingId;

  @override
  ConsumerState<ScheduleCreatePage> createState() => _ScheduleCreatePageState();
}

/// 글자 입력 컨트롤러 3개와 선택한 시작/종료 일시를 들고 있습니다.
class _ScheduleCreatePageState extends ConsumerState<ScheduleCreatePage> {
  final _title = TextEditingController();
  final _location = TextEditingController();
  final _description = TextEditingController();
  DateTime? _startAt;
  DateTime? _endAt;

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

  /// 현재 입력값으로 일정 생성을 요청합니다.
  void _submit() {
    FocusScope.of(context).unfocus();
    ref
        .read(scheduleCreateProvider(widget.meetingId).notifier)
        .submit(
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

  /// 제출 상태가 바뀌면: 성공이면 화면을 닫고, 실패하면 안내합니다.
  void _onStateChanged(
    ScheduleCreateState? previous,
    ScheduleCreateState next,
  ) {
    if (previous?.status == next.status) return;
    if (next.status == ScheduleCreateStatus.success) {
      context.pop();
    } else if (next.status == ScheduleCreateStatus.failure) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('일정을 만들지 못했어요')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = scheduleCreateProvider(widget.meetingId);
    ref.listen(provider, _onStateChanged);
    final state = ref.watch(provider);

    return Scaffold(
      backgroundColor: MoaColors.page,
      appBar: MoaAppBar(),
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
                onPickStart: _pickStart,
                onPickEnd: _pickEnd,
              ),
            ),
            _SubmitButton(
              onPressed:
                  state.status == ScheduleCreateStatus.submitting ||
                      _title.text.trim().isEmpty ||
                      _startAt == null
                  ? null
                  : _submit,
            ),
          ],
        ),
      ),
    );
  }
}

/// 입력 영역: 이름, 시작/종료 일시, 장소, 설명. 길어질 수 있어서 스크롤됩니다.
///
/// 값은 직접 들고 있지 않고, 글자 입력은 컨트롤러로, 일시는 [startAt]/[endAt] 로 받아 보여줍니다.
/// 일시 칸을 누르면 [onPickStart]/[onPickEnd] 가 호출됩니다.
class _CreateForm extends StatelessWidget {
  const _CreateForm({
    required this.titleController,
    required this.locationController,
    required this.descriptionController,
    required this.startAt,
    required this.endAt,
    required this.onPickStart,
    required this.onPickEnd,
  });

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
          Text('일정 만들기', style: MoaText.titleXl),
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
      label,
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
    return _Field(label, child: _PickerBox(value, '날짜와 시간을 선택해 주세요', onTap));
  }
}

/// 하단 "일정 만들기" 버튼입니다. [onPressed] 가 null 이면 비활성화됩니다.
/// (이름이나 시작 일시가 비어 있거나 제출 중일 때)
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

/// 라벨과 입력 상자입니다.
class _Field extends StatelessWidget {
  const _Field(this.label, {required this.child});

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
