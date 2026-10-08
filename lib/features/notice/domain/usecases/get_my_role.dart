import '../entities/member_role.dart';
import '../repositories/notice_repository.dart';
import 'usecase.dart';

/// GetMyRole 전용 파라미터
final class GetMyRoleParams extends Params {
  const GetMyRoleParams({required this.meetingId});

  final int meetingId;
}

/// 모임에서 내 역할 조회 (1-4 의 myRole)
abstract class GetMyRole extends Usecase<MemberRole, GetMyRoleParams> {}

final class GetMyRoleImpl implements GetMyRole {
  GetMyRoleImpl({required this._repository});

  final NoticeRepository _repository;

  @override
  Future<MemberRole> call(GetMyRoleParams params) {
    return _repository.getMyRole(meetingId: params.meetingId);
  }
}
