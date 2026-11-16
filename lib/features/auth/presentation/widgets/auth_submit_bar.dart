import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 회원·인증 화면 아래쪽의 검정 버튼 (Figma "Bottom Bar")
///
/// [isLoading] 이면 글자 대신 진행 표시를 보여주고 누를 수 없습니다.
/// [footer] 를 주면 버튼 아래에 보여줍니다. (예: 회원가입 링크, 나중에 할게요)
/// [isDanger] 면 되돌릴 수 없는 동작(회원 탈퇴)처럼 연한 빨강 바탕에 빨간 글자로 보여줍니다.
class AuthSubmitBar extends StatelessWidget {
  const AuthSubmitBar({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.footer,
    this.isDanger = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final Widget? footer;
  final bool isDanger;

  Color get _background => isDanger ? MoaColors.dangerTint : MoaColors.accent;

  Color get _foreground => isDanger ? MoaColors.danger : MoaColors.textInverse;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 56,
              width: double.infinity,
              child: FilledButton(
                onPressed: isLoading ? null : onPressed,
                style: FilledButton.styleFrom(
                  backgroundColor: _background,
                  disabledBackgroundColor: _background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: isLoading
                    ? SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: _foreground,
                        ),
                      )
                    : Text(
                        label,
                        style: MoaText.button.copyWith(color: _foreground),
                      ),
              ),
            ),
            if (footer != null) ...[const SizedBox(height: 10), footer!],
          ],
        ),
      ),
    );
  }
}
