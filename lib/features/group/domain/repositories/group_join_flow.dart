import '../entities/group.dart';

/// 가입 전 조회·승인 요청을 지원하는 저장소의 선택적 기능입니다.
/// 현재 서버 계약에는 없어 개발용 저장소에서만 제공합니다.
abstract interface class GroupJoinFlow {
  Future<Group> previewInviteCode(String code);
  Future<Group> requestJoin(String code);
  List<Group> get pendingRequests;
  bool requiresApproval(int groupId);
  void setApprovalRequired(int groupId);
}
