import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_notice_request.freezed.dart';

/// 공지 고정 요청
@freezed
abstract class PinNoticeRequest with _$PinNoticeRequest {
  const factory PinNoticeRequest({
    required int meetingId,
    required int noticeId,
  }) = _PinNoticeRequest;
}
