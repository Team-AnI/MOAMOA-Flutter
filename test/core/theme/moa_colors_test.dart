import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/theme/moa_theme.dart';
import 'package:moamoa/features/group/presentation/widgets/group_design.dart';
import 'package:moamoa/features/notice/presentation/widgets/notice_colors.dart';

void main() {
  group(MoaColors, () {
    test('모임과 공지의 같은 의미 색은 공통 토큰의 기존 색 값을 사용한다', () {
      for (final (group, notice, common, expected) in [
        (
          GroupDesign.ink,
          NoticeColors.text,
          MoaColors.textPrimary,
          const Color(0xff1d1d1f),
        ),
        (
          GroupDesign.secondary,
          NoticeColors.bodyText,
          MoaColors.textSecondary,
          const Color(0xff333333),
        ),
        (
          GroupDesign.muted,
          NoticeColors.subText,
          MoaColors.textTertiary,
          const Color(0xff7a7a7a),
        ),
        (
          GroupDesign.fill,
          NoticeColors.gray,
          MoaColors.fill,
          const Color(0xfff5f5f7),
        ),
      ]) {
        expect(group, common);
        expect(notice, common);
        expect(common, expected);
      }
      expect(GroupDesign.blue, MoaColors.accentText);
      expect(GroupDesign.tint, MoaColors.accentTint);
    });

    test('위험 동작과 스크림은 기존 값을 보존하고 오류 안내 색과 구분한다', () {
      expect(GroupDesign.danger, MoaColors.danger);
      expect(MoaColors.danger, const Color(0xffe30000));
      expect(GroupDesign.dangerTint, MoaColors.dangerTint);
      expect(MoaColors.dangerTint, const Color(0xfffdecec));
      expect(GroupDesign.barrier, MoaColors.barrier);
      expect(MoaColors.barrier, const Color(0x8f000000));
      expect(MoaColors.error, const Color(0xffd92d20));
      expect(NoticeColors.error, const Color(0xfff04452));
    });

    test('어두운 배경과 보조 요소의 공통 토큰은 모임의 기존 색 값을 보존한다', () {
      for (final (group, common, expected) in [
        (
          GroupDesign.onDarkSecondary,
          MoaColors.onDarkSecondary,
          const Color(0xffcccccc),
        ),
        (GroupDesign.darkFill, MoaColors.darkFill, const Color(0xff38383a)),
        (GroupDesign.darkRaised, MoaColors.darkRaised, const Color(0xff272729)),
        (
          GroupDesign.placeholder,
          MoaColors.placeholder,
          const Color(0xffd2d2d7),
        ),
        (GroupDesign.shadow, MoaColors.shadow, const Color(0x14000000)),
      ]) {
        expect(group, common);
        expect(common, expected);
      }
    });
  });
}
