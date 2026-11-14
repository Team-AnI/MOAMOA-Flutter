import 'package:freezed_annotation/freezed_annotation.dart';

import 'notice_author.dart';

part 'notice.freezed.dart';

/// 모임 공지
///
/// 목록 조회(3-2)에서는 [content] 가 없고, 상세 조회(3-3)에서만 채워집니다.
/// [author] 는 목록·상세 모두 오지만, 서버가 아직 보내지 않는 동안에는 null 입니다.
@freezed
abstract class Notice with _$Notice {
  const factory Notice({
    required int id,
    required String title,
    required DateTime createdAt,
    String? content,
    NoticeAuthor? author,
  }) = _Notice;
}
