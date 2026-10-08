import '../repositories/group_repository.dart';
import 'create_group.dart';
import 'params/create_group_params.dart';
import '../entities/current_group.dart';

final class CreateGroupImpl implements CreateGroup {
  const CreateGroupImpl({required this.repository});
  final GroupRepository repository;
  @override
  Future<CurrentGroup> call(CreateGroupParams params) {
    final name = params.name.trim();
    if (name.isEmpty) throw ArgumentError('모임명을 입력해주세요.');
    return repository.createGroup(
      name: name,
      description: params.description.trim(),
    );
  }
}
