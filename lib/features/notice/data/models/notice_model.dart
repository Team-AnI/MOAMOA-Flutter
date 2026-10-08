import '../../domain/entities/notice.dart';

/// 공지 응답 모델 (3-2 목록의 항목, 3-3 상세)
///
/// 목록 항목에는 content 가 없습니다.
class NoticeModel {
  const NoticeModel({
    required this.noticeId,
    required this.title,
    required this.createdAt,
    this.content,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      noticeId: json['noticeId'] as int,
      title: json['title'] as String,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String,
    );
  }

  final int noticeId;
  final String title;
  final String? content;

  /// ISO-8601 (KST, 예: 2026-10-07T10:00:00+09:00)
  final String createdAt;

  Notice toEntity() => Notice(
    id: noticeId,
    title: title,
    content: content,
    createdAt: DateTime.parse(createdAt).toLocal(),
  );
}
