import 'package:flutter/foundation.dart';

/// 공지 작성·수정·삭제 권한 (관리자만 가능)
class NoticeWriteAccess {
  const NoticeWriteAccess({required this.canWrite, this.retryRole});

  /// 관리자로 확인되었을 때만 true. 확인 중이거나 실패하면 false 입니다.
  final bool canWrite;

  /// 역할 조회에 실패했을 때만 있는 다시 시도 동작. 실패하지 않았으면 null 입니다.
  final VoidCallback? retryRole;
}
