import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 회원·인증 화면 아래쪽의 검정 버튼 (Figma "Bottom Bar")
///
/// [isLoading] 이면 글자 대신 진행 표시를 보여주고 누를 수 없습니다.
/// [footer] 를 주면 버튼 아래에 보여줍니다. (예: 회원가입 링크, 나중에 할게요)
class AuthSubmitBar extends StatelessWidget {
  const AuthSubmitBar({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.footer,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final Widget? footer;

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
                  backgroundColor: MoaColors.accent,
                  disabledBackgroundColor: MoaColors.accent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: isLoading
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: MoaColors.textInverse,
                        ),
                      )
                    : Text(
                        label,
                        style: MoaText.button.copyWith(
                          color: MoaColors.textInverse,
                        ),
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
