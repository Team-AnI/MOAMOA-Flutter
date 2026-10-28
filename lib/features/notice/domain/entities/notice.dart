import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice.freezed.dart';

/// 모임 공지
///
/// 목록 조회(3-2)에서는 [content] 가 없고, 상세 조회(3-3)에서만 채워집니다.
@freezed
abstract class Notice with _$Notice {
  const factory Notice({
    required int id,
    required String title,
    required DateTime createdAt,
    String? content,
  }) = _Notice;
}
