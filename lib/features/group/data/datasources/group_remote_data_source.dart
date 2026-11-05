import '../models/group_member_model.dart';
import '../models/group_update_model.dart';
import '../models/meeting_model.dart';
import '../requests/delete_group_request.dart';
import '../requests/group_members_request.dart';
import '../requests/update_group_request.dart';

abstract interface class GroupRemoteDataSource {
  Future<GroupUpdateModel> updateGroup(UpdateGroupRequest request);
  Future<void> deleteGroup(DeleteGroupRequest request);
  Future<List<MeetingModel>> fetchMyGroups();
  Future<List<GroupMemberModel>> fetchMembers(GroupMembersRequest request);
  Future<MeetingModel> fetchGroup(int groupId);
  Future<MeetingModel> createGroup({required String name, String? description});
  Future<MeetingModel> joinGroup(String inviteCode);
  Future<String> fetchInviteCode(int groupId);
}
