import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

import 'vote_colors.dart';

/// 화면·시트 아래의 큰 버튼입니다. (Figma "Button" / "Button Disabled")
///
/// [onPressed] 가 null 이면 회색으로 보이고 눌리지 않습니다.
/// 회색으로 보이면서 눌려야 할 때(누르면 빈 항목을 알려주는 경우)는 [enabled] 를 false 로 둡니다.
class VotePrimaryButton extends StatelessWidget {
  const VotePrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool enabled;

  Color get _background => enabled ? MoaColors.accent : MoaColors.fill;

  Color get _foreground =>
      enabled ? MoaColors.textInverse : VoteColors.textDisabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: _background,
          foregroundColor: _foreground,
          disabledBackgroundColor: MoaColors.fill,
          disabledForegroundColor: VoteColors.textDisabled,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          // 버튼 글자 스타일은 앱 테마 글꼴을 물려받지 않아서 글꼴을 직접 지정합니다.
          textStyle: MoaText.button.copyWith(fontFamily: 'Pretendard'),
        ),
        child: Text(label),
      ),
    );
  }
}
