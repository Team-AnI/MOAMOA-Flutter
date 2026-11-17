import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice_detail_request.freezed.dart';

/// 공지 하나를 가리키는 키. 상세 · 삭제 · 읽음 처리 provider 의 family 인자로 씁니다.
@freezed
abstract class NoticeDetailRequest with _$NoticeDetailRequest {
  const factory NoticeDetailRequest({
    required int meetingId,
    required int noticeId,
  }) = _NoticeDetailRequest;
}
