import 'package:flutter/material.dart';
import 'package:moamoa/core/theme/moa_theme.dart';

/// 회원가입 단계 막대 (Figma "Step Bar": 가입 → 프로필 설정)
///
/// [step] 번째까지 진하게 칠합니다.
class AuthStepBar extends StatelessWidget {
  const AuthStepBar({super.key, required this.step, this.total = 2});

  /// 지금 단계. 1부터 셉니다.
  final int step;
  final int total;

  Color _colorAt(int index) =>
      index < step ? MoaColors.accent : MoaColors.profileGray;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < total; i++) ...[
          if (i > 0) const SizedBox(width: 6),
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: _colorAt(i),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
