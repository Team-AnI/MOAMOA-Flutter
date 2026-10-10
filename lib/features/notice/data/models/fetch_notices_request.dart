import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_notices_request.freezed.dart';
part 'fetch_notices_request.g.dart';

/// 공지 목록 조회(3-2) 요청. [toJson] 은 쿼리 파라미터(page, size)가 됩니다.
@freezed
abstract class FetchNoticesRequest with _$FetchNoticesRequest {
  const factory FetchNoticesRequest({
    @JsonKey(includeToJson: false) required int meetingId,

    /// 0부터 시작
    required int page,
    required int size,
  }) = _FetchNoticesRequest;

  factory FetchNoticesRequest.fromJson(Map<String, dynamic> json) =>
      _$FetchNoticesRequestFromJson(json);
}
