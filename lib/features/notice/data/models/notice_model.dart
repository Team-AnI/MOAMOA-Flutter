import '../../domain/entities/notice.dart';
import 'notice_account_model.dart';

/// 공지 응답 모델 (3-2 목록의 항목, 3-3 상세)
///
/// 목록 항목에는 content 가 없습니다.
/// authorNickname, isPinned, account 는 API 명세에 아직 없는 가정 필드입니다.
/// 백엔드와 필드 이름이 확정되면 [NoticeModel.fromJson] 만 맞추면 됩니다.
class NoticeModel {
  const NoticeModel({
    required this.noticeId,
    required this.title,
    required this.createdAt,
    this.content,
    this.authorNickname,
    this.isPinned,
    this.account,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    final account = json['account'];
    return NoticeModel(
      noticeId: json['noticeId'] as int,
      title: json['title'] as String,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String,
      authorNickname: json['authorNickname'] as String?,
      isPinned: json['isPinned'] as bool?,
      account: account is Map<String, dynamic>
          ? NoticeAccountModel.fromJson(account)
          : null,
    );
  }

  final int noticeId;
  final String title;
  final String? content;

  /// ISO-8601 (KST, 예: 2026-10-07T10:00:00+09:00)
  final String createdAt;

  final String? authorNickname;
  final bool? isPinned;
  final NoticeAccountModel? account;

  Notice toEntity() => Notice(
    id: noticeId,
    title: title,
    content: content,
    createdAt: DateTime.parse(createdAt).toLocal(),
    authorName: authorNickname,
    isPinned: isPinned ?? false,
    account: account?.toEntity(),
  );
}
