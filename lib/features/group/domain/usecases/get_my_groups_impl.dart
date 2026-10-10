import '../../../../core/usecases/no_params.dart';
import '../entities/current_group.dart';
import '../repositories/group_repository.dart';
import 'get_my_groups.dart';

final class GetMyGroupsImpl implements GetMyGroups {
  const GetMyGroupsImpl({required this.repository});
  final GroupRepository repository;
  @override
  Future<List<CurrentGroup>> call(NoParams params) {
    return repository.getMyGroups();
  }
}
