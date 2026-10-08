/// 공지 작성(3-1) / 수정(3-4) 요청 모델
///
/// 수정(PATCH)은 보낸 필드만 변경되므로, null 인 필드는 보내지 않습니다.
class NoticeRequestModel {
  const NoticeRequestModel({this.title, this.content});

  final String? title;
  final String? content;

  Map<String, dynamic> toJson() => {
    if (title != null) 'title': title,
    if (content != null) 'content': content,
  };
}
