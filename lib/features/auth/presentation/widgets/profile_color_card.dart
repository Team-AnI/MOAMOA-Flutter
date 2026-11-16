import 'package:flutter/material.dart';
import 'package:moamoa/core/constants/profile_color.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/core/widgets/moa_profile_avatar.dart';

/// 화면에 보여줄 프로필 색 이름 (화면 읽기 프로그램이 읽어 줍니다)
extension ProfileColorLabelX on ProfileColor {
  String get label => switch (this) {
    ProfileColor.lightBlue => '연파랑',
    ProfileColor.gray => '회색',
    ProfileColor.blue => '진한 파랑',
    ProfileColor.dark => '검정',
  };
}

/// 기본 프로필 색 4개 중 하나를 고르는 카드 (Figma "Color Card")
///
/// 가입 직후 프로필 설정과 프로필 편집에서 함께 씁니다.
class ProfileColorCard extends StatelessWidget {
  const ProfileColorCard({
    super.key,
    required this.userName,
    required this.selected,
    required this.onSelected,
  });

  final String? userName;
  final ProfileColor selected;
  final ValueChanged<ProfileColor> onSelected;

  bool _isSelected(ProfileColor color) => color == selected;

  /// 고른 색에만 진한 테두리를 둘러 줍니다.
  BoxBorder? _border(ProfileColor color) =>
      _isSelected(color) ? Border.all(color: MoaColors.accent, width: 2) : null;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: MoaColors.fill,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '기본 프로필 색',
                style: MoaText.subStrong.copyWith(
                  color: MoaColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // 색 고르기
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              // 좁은 화면(320)에서는 넘치지 않게 4개를 함께 줄입니다. 넓으면 60 그대로입니다.
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final color in ProfileColor.values)
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        // 동그라미 안 이름 첫 글자 대신 색 이름만 읽어 줍니다.
                        child: Semantics(
                          button: true,
                          selected: _isSelected(color),
                          label: color.label,
                          excludeSemantics: true,
                          onTap: () => onSelected(color),
                          child: GestureDetector(
                            onTap: () => onSelected(color),
                            child: Container(
                              width: 60,
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: _border(color),
                              ),
                              child: MoaProfileAvatar(
                                userName: userName,
                                color: color,
                                size: 48,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
