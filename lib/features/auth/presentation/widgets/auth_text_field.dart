import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 회원·인증 화면의 입력칸 (Figma "Field": 라벨 + 회색 입력칸)
///
/// 비밀번호 찾기·재설정·로그인·회원가입에서 함께 씁니다.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;

  /// 값이 있으면 입력칸 아래에 안내를 보여주고 테두리를 오류 색으로 바꿉니다.
  final String? errorText;

  /// 비밀번호처럼 입력한 글자를 가립니다.
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  static OutlineInputBorder _border(BorderSide side) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: side,
  );

  @override
  Widget build(BuildContext context) {
    final errorBorder = _border(const BorderSide(color: MoaColors.error));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 라벨
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            label,
            style: MoaText.subStrong.copyWith(color: MoaColors.textSecondary),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: MoaText.body,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: MoaText.body.copyWith(color: MoaColors.textTertiary),
            errorText: errorText,
            errorStyle: MoaText.caption.copyWith(color: MoaColors.error),
            filled: true,
            fillColor: MoaColors.fill,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            border: _border(BorderSide.none),
            enabledBorder: _border(BorderSide.none),
            focusedBorder: _border(
              const BorderSide(color: MoaColors.accent, width: 2),
            ),
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
          ),
        ),
      ],
    );
  }
}
