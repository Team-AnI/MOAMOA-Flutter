import '../models/group_update_model.dart';
import '../models/meeting_model.dart';
import '../requests/update_group_request.dart';

abstract interface class GroupRemoteDataSource {
  Future<GroupUpdateModel> updateGroup({
    required int groupId,
    required UpdateGroupRequest request,
  });
  Future<void> deleteGroup(int groupId);
  Future<List<MeetingModel>> fetchMyGroups();
  Future<MeetingModel> fetchGroup(int groupId);
  Future<MeetingModel> createGroup({required String name, String? description});
  Future<MeetingModel> joinGroup(String inviteCode);
  Future<String> fetchInviteCode(int groupId);
}
