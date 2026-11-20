import 'package:freezed_annotation/freezed_annotation.dart';

part 'regular_dues_list_request.freezed.dart';
part 'regular_dues_list_request.g.dart';

@freezed
abstract class RegularDuesListRequest with _$RegularDuesListRequest {
  const factory RegularDuesListRequest({
    @JsonKey(includeToJson: false) required int meetingId,
  }) = _RegularDuesListRequest;
  factory RegularDuesListRequest.fromJson(Map<String, dynamic> json) =>
      _$RegularDuesListRequestFromJson(json);
}
