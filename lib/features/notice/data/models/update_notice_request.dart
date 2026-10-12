import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_notice_request.freezed.dart';
part 'update_notice_request.g.dart';

/// 공지 수정(3-4) 요청. [toJson] 은 요청 본문이 됩니다.
///
/// PATCH 는 보낸 필드만 변경되므로, null 인 필드는 본문에서 뺍니다.
@freezed
abstract class UpdateNoticeRequest with _$UpdateNoticeRequest {
  const factory UpdateNoticeRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    @JsonKey(includeToJson: false) required int noticeId,
    @JsonKey(includeIfNull: false) String? title,
    @JsonKey(includeIfNull: false) String? content,
  }) = _UpdateNoticeRequest;

  factory UpdateNoticeRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateNoticeRequestFromJson(json);
}
