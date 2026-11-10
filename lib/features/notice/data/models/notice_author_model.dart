import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moamoa/core/constants/profile_color.dart';

import '../../domain/entities/notice_author.dart';

part 'notice_author_model.freezed.dart';
part 'notice_author_model.g.dart';

/// 공지 작성자 응답 모델 (3-2 목록 항목, 3-3 상세의 author)
@freezed
abstract class NoticeAuthorModel with _$NoticeAuthorModel {
  const factory NoticeAuthorModel({
    required int memberId,
    String? userName,

    /// LIGHT_BLUE · GRAY · BLUE · DARK
    String? profileColor,
  }) = _NoticeAuthorModel;

  factory NoticeAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeAuthorModelFromJson(json);
}

/// 응답 모델을 도메인 Entity 로 바꿉니다.
extension NoticeAuthorModelX on NoticeAuthorModel {
  NoticeAuthor toEntity() => NoticeAuthor(
    memberId: memberId,
    userName: userName,
    profileColor: ProfileColor.fromServer(profileColor),
  );
}
