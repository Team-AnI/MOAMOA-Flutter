import 'package:freezed_annotation/freezed_annotation.dart';

part 'mark_notice_read_request.freezed.dart';

/// 공지 읽음 처리(3-6) 요청. 요청 본문은 없고 경로에만 씁니다.
@freezed
abstract class MarkNoticeReadRequest with _$MarkNoticeReadRequest {
  const factory MarkNoticeReadRequest({
    required int meetingId,
    required int noticeId,
  }) = _MarkNoticeReadRequest;
}
