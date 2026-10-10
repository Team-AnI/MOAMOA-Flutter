import '../entities/current_group.dart';
import '../repositories/group_repository.dart';
import 'create_group.dart';

final class CreateGroupImpl implements CreateGroup {
  const CreateGroupImpl({required this.repository});
  final GroupRepository repository;
  @override
  Future<CurrentGroup> call(CreateGroupParams params) {
    final name = params.name.trim();
    if (name.isEmpty) throw const GroupFailure(GroupFailureReason.validation);
    return repository.createGroup(
      CreateGroupParams(name: name, description: params.description.trim()),
    );
  }
}
