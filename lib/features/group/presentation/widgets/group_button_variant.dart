import 'package:flutter/material.dart';

import 'group_design.dart';

/// 버튼은 한 종류만 선택할 수 있어 보조/위험 스타일의 중복 지정이 불가능합니다.
enum GroupButtonVariant {
  primary(GroupDesign.ink, Colors.white),
  secondary(GroupDesign.fill, GroupDesign.ink),
  destructive(GroupDesign.dangerTint, GroupDesign.danger);

  const GroupButtonVariant(this.background, this.foreground);
  final Color background, foreground;
}
