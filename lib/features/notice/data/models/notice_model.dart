import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notice.dart';

part 'notice_model.freezed.dart';
part 'notice_model.g.dart';

/// 공지 응답 모델 (3-2 목록의 항목, 3-3 상세)
@freezed
abstract class NoticeModel with _$NoticeModel {
  const NoticeModel._();

  const factory NoticeModel({
    required int noticeId,
    required String title,

    /// ISO-8601 (KST, 예: 2026-10-07T10:00:00+09:00)
    required String createdAt,
    String? content,
    String? authorNickname,
    bool? isPinned,
    bool? isImportant,
    bool? isEdited,
  }) = _NoticeModel;

  factory NoticeModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeModelFromJson(json);

  Notice toEntity() => Notice(
    id: noticeId,
    title: title,
    content: content,
    createdAt: DateTime.parse(createdAt).toLocal(),
    authorName: authorNickname,
    isPinned: isPinned ?? false,
    isImportant: isImportant ?? false,
    isEdited: isEdited ?? false,
  );
}
