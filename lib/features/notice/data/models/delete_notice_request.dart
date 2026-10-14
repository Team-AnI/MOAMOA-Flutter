import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_notice_request.freezed.dart';

/// 공지 삭제(3-5) 요청
@freezed
abstract class DeleteNoticeRequest with _$DeleteNoticeRequest {
  const factory DeleteNoticeRequest({
    required int meetingId,
    required int noticeId,
  }) = _DeleteNoticeRequest;
}
