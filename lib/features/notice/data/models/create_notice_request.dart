import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_notice_request.freezed.dart';
part 'create_notice_request.g.dart';

/// 공지 작성(3-1) 요청. [toJson] 은 요청 본문(title, content)이 됩니다.
@freezed
abstract class CreateNoticeRequest with _$CreateNoticeRequest {
  const factory CreateNoticeRequest({
    @JsonKey(includeToJson: false) required int meetingId,
    required String title,
    required String content,
    // TODO: API 명세 확정 시 필드 이름 확인 (임시: isImportant)
    @Default(false) bool isImportant,
  }) = _CreateNoticeRequest;

  factory CreateNoticeRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateNoticeRequestFromJson(json);
}
