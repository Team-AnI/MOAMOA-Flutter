import '../entities/current_group.dart';
import '../repositories/group_repository.dart';
import 'get_group.dart';
import 'params/get_group_params.dart';

final class GetGroupImpl implements GetGroup {
  const GetGroupImpl({required this.repository});
  final GroupRepository repository;
  @override
  Future<CurrentGroup> call(GetGroupParams params) {
    return repository.getGroup(params.groupId);
  }
}
