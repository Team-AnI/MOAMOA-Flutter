import '../../domain/entities/group.dart';

/// 서버에서 받은 구성원 수의 화면 표시 규칙입니다.
extension GroupDisplayX on Group {
  String? get memberCountText {
    final count = memberCount;
    return count is int && count >= 0 ? '$count명' : null;
  }

  String? get memberCountLabel {
    final text = memberCountText;
    return text == null ? null : '구성원 $text';
  }
}
