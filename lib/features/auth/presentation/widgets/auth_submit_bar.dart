import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 회원·인증 화면 아래쪽의 검정 버튼 (Figma "Bottom Bar")
///
/// [isLoading] 이면 글자 대신 진행 표시를 보여주고 누를 수 없습니다.
class AuthSubmitBar extends StatelessWidget {
  const AuthSubmitBar({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: SizedBox(
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
      ),
    );
  }
}
