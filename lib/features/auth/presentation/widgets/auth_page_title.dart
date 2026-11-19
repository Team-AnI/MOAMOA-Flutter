import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 회원·인증 화면 위쪽의 제목과 안내 문구
///
/// 비밀번호 찾기·재설정·로그인·회원가입에서 함께 씁니다.
class AuthPageTitle extends StatelessWidget {
  const AuthPageTitle({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: MoaText.titleXl),
        const SizedBox(height: 6),
        Text(
          description,
          style: MoaText.body.copyWith(color: MoaColors.textSecondary),
        ),
      ],
    );
  }
}
