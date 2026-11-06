import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_notice_detail_request.freezed.dart';

/// 공지 상세 조회(3-3) 요청
@freezed
abstract class FetchNoticeDetailRequest with _$FetchNoticeDetailRequest {
  const factory FetchNoticeDetailRequest({
    required int meetingId,
    required int noticeId,
  }) = _FetchNoticeDetailRequest;
}
