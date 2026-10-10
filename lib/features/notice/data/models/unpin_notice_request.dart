import 'package:freezed_annotation/freezed_annotation.dart';

part 'unpin_notice_request.freezed.dart';

/// 공지 고정 해제 요청
@freezed
abstract class UnpinNoticeRequest with _$UnpinNoticeRequest {
  const factory UnpinNoticeRequest({
    required int meetingId,
    required int noticeId,
  }) = _UnpinNoticeRequest;
}
