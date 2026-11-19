import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 동그란 체크와 문구 한 줄 (Figma "Agree")
///
/// 회원가입의 약관 동의와 회원 탈퇴의 안내 확인에서 함께 씁니다.
class AuthCheckRow extends StatelessWidget {
  const AuthCheckRow({
    super.key,
    required this.checked,
    required this.label,
    required this.onToggle,
  });

  final bool checked;
  final String label;
  final VoidCallback onToggle;

  /// 체크하면 진하게, 아니면 연한 회색으로 동그라미를 칠합니다.
  Color get _checkColor => checked ? MoaColors.accent : MoaColors.placeholder;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      checked: checked,
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _checkColor,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/icons/check_bold.svg',
                  width: 13,
                  height: 13,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(label, style: MoaText.sub)),
            ],
          ),
        ),
      ),
    );
  }
}
