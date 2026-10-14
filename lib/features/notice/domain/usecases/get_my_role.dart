import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/member_role.dart';
import '../repositories/notice_repository.dart';
import 'usecase.dart';

part 'get_my_role.freezed.dart';

/// GetMyRole 전용 파라미터
@freezed
abstract class GetMyRoleParams extends Params with _$GetMyRoleParams {
  const GetMyRoleParams._();

  const factory GetMyRoleParams({required int meetingId}) = _GetMyRoleParams;
}

/// 모임에서 내 역할 조회 (1-4 의 myRole)
abstract class GetMyRole extends Usecase<MemberRole, GetMyRoleParams> {}

final class GetMyRoleImpl implements GetMyRole {
  GetMyRoleImpl({required NoticeRepository noticeRepository})
    : _noticeRepository = noticeRepository;

  final NoticeRepository _noticeRepository;

  @override
  Future<MemberRole> call(GetMyRoleParams params) {
    return _noticeRepository.getMyRole(meetingId: params.meetingId);
  }
}
