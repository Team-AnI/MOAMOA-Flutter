import 'package:flutter/material.dart';

import '../../domain/entities/notice_exception.dart';
import 'notice_colors.dart';

/// 에러를 사용자에게 보여줄 메시지로 바꿉니다.
String noticeErrorMessage(Object? error) {
  if (error is NoticeException) return error.message;
  return '알 수 없는 오류가 발생했습니다.';
}

/// 서버가 NOT_FOUND 를 보냈는지 (삭제되었거나 존재하지 않음)
bool isNoticeNotFound(Object? error) =>
    error is NoticeException && error.code == 'NOT_FOUND';

/// 공지 목록 / 상세 조회 실패 화면
class NoticeErrorView extends StatelessWidget {
  const NoticeErrorView({
    super.key,
    required this.error,
    required this.onAction,
    this.message,
    this.actionLabel = '다시 시도',
  });

  final Object error;
  final VoidCallback onAction;

  /// 없으면 [error] 의 메시지를 보여줍니다.
  final String? message;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message ?? noticeErrorMessage(error),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: NoticeColors.icon),
            ),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: onAction, child: Text(actionLabel)),
          ],
        ),
      ),
    );
  }
}
