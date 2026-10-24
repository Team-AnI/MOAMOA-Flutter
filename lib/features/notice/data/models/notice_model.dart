import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notice.dart';

part 'notice_model.freezed.dart';
part 'notice_model.g.dart';

/// 공지 응답 모델 (3-2 목록의 항목, 3-3 상세)
@freezed
abstract class NoticeModel with _$NoticeModel {
  const factory NoticeModel({
    required int noticeId,
    required String title,

    /// ISO-8601 (KST, 예: 2026-10-07T10:00:00+09:00)
    required String createdAt,
    String? content,
  }) = _NoticeModel;

  factory NoticeModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeModelFromJson(json);
}

/// 응답 모델을 도메인 Entity 로 바꿉니다.
///
/// 생성 코드와 분리해 두어, 변환 로직을 고칠 때 build_runner 를 다시 돌리지 않아도 됩니다.
extension NoticeModelX on NoticeModel {
  Notice toEntity() => Notice(
    id: noticeId,
    title: title,
    content: content,
    createdAt: DateTime.parse(createdAt).toLocal(),
  );
}
