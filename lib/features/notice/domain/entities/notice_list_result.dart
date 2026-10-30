import 'package:freezed_annotation/freezed_annotation.dart';

import 'notice.dart';

part 'notice_list_result.freezed.dart';

/// 페이지 단위 공지 목록 조회 결과 (3-2)
@freezed
abstract class NoticeListResult with _$NoticeListResult {
  const factory NoticeListResult({
    required List<Notice> notices,
    required int page,
    required int size,
    required bool hasNext,
  }) = _NoticeListResult;
}
