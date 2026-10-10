import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_my_role_request.freezed.dart';

/// 모임 상세(1-4)의 myRole 조회 요청
@freezed
abstract class FetchMyRoleRequest with _$FetchMyRoleRequest {
  const factory FetchMyRoleRequest({required int meetingId}) =
      _FetchMyRoleRequest;
}
