import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_notice_reads_request.freezed.dart';

/// 공지 읽음 현황(3-7) 요청. 요청 본문은 없고 경로에만 씁니다.
@freezed
abstract class FetchNoticeReadsRequest with _$FetchNoticeReadsRequest {
  const factory FetchNoticeReadsRequest({
    required int meetingId,
    required int noticeId,
  }) = _FetchNoticeReadsRequest;
}
