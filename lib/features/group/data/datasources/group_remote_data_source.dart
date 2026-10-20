import '../models/meeting_model.dart';

abstract interface class GroupRemoteDataSource {
  Future<List<MeetingModel>> fetchMyGroups();
  Future<MeetingModel> fetchGroup(int groupId);
  Future<MeetingModel> createGroup({required String name, String? description});
  Future<MeetingModel> joinGroup(String inviteCode);
  Future<String> fetchInviteCode(int groupId);
}
