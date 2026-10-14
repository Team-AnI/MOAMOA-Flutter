import 'package:flutter/material.dart';

import 'notice_colors.dart';

/// 내 역할(관리자 여부) 조회에 실패했을 때 보여주는 다시 시도 버튼
///
/// 실패를 숨기면 관리자도 일반 구성원처럼 보이므로, 확인하지 못했다는 걸 알리고 재시도하게 합니다.
class NoticeRoleRetryButton extends StatelessWidget {
  const NoticeRoleRetryButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: '권한 확인 다시 시도',
      icon: const Icon(Icons.refresh, color: NoticeColors.icon),
    );
  }
}
