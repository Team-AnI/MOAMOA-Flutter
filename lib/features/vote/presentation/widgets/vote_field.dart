import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

import 'vote_colors.dart';

/// 라벨, 회색 입력 상자, 오류 문구로 된 입력 칸입니다. (Figma "Field" / "Link Row")
///
/// - [input] 이 있으면 상자 안에 그대로 넣고(글자 입력), 없으면 [value] 를 보여줍니다.
///   [value] 가 null 이면 [placeholder] 를 흐리게 보여줍니다.
/// - [onTap] 이 있으면 상자를 눌러 값을 고르는 칸이 되고 오른쪽에 화살표가 붙습니다.
/// - [error] 가 있으면 라벨·테두리·아이콘이 빨갛게 바뀌고 아래에 문구가 붙습니다.
class VoteField extends StatelessWidget {
  const VoteField({
    super.key,
    required this.label,
    this.input,
    this.value,
    this.placeholder = '',
    this.icon,
    this.error,
    this.onTap,
  });

  final String label;
  final Widget? input;
  final String? value;
  final String placeholder;

  /// `assets/icons/` 의 아이콘 이름. 오류가 있으면 이름 뒤에 `_error` 가 붙은 아이콘을 씁니다.
  final String? icon;
  final String? error;
  final VoidCallback? onTap;

  bool get _hasError => error != null;

  Color get _labelColor =>
      _hasError ? VoteColors.alert : MoaColors.textSecondary;

  String? get _iconPath => icon == null
      ? null
      : 'assets/icons/$icon${_hasError ? '_error' : ''}.svg';

  Color get _valueColor =>
      value == null ? VoteColors.textDisabled : MoaColors.textPrimary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            label,
            style: MoaText.subStrong.copyWith(color: _labelColor),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: MoaColors.fill,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              border: _hasError
                  ? Border.all(color: VoteColors.alert, width: 1.5)
                  : null,
            ),
            child: Row(
              spacing: 10,
              children: [
                if (_iconPath case final path?) SvgPicture.asset(path),
                Expanded(
                  child:
                      input ??
                      Text(
                        value ?? placeholder,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: MoaText.body.copyWith(color: _valueColor),
                      ),
                ),
                if (onTap != null)
                  SvgPicture.asset('assets/icons/caret_right.svg'),
              ],
            ),
          ),
        ),
        if (error case final message?) _FieldError(message: message),
      ],
    );
  }
}

/// 입력 상자 아래의 경고 아이콘과 오류 문구입니다.
class _FieldError extends StatelessWidget {
  const _FieldError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        spacing: 6,
        children: [
          SvgPicture.asset('assets/icons/warning_circle.svg'),
          Text(
            message,
            style: MoaText.caption.copyWith(color: VoteColors.alert),
          ),
        ],
      ),
    );
  }
}
