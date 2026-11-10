import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/core/constants/profile_color.dart';

part 'notice_author.freezed.dart';

/// 공지 작성자 (목록 3-2, 상세 3-3 의 author)
///
/// 작성자가 모임을 나가거나 탈퇴하면 [userName] 은 "탈퇴한 사용자" 로 오고 [memberId] 는 그대로입니다.
/// [profileColor] 가 없거나 모르는 값이면 기본 연파랑입니다.
@freezed
abstract class NoticeAuthor with _$NoticeAuthor {
  const factory NoticeAuthor({
    required int memberId,
    String? userName,
    @Default(ProfileColor.lightBlue) ProfileColor profileColor,
  }) = _NoticeAuthor;
}
