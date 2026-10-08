import '../entities/current_group.dart';
import '../repositories/group_repository.dart';

class CreateGroup {
  const CreateGroup(this._repository);
  final GroupRepository _repository;

  Future<CurrentGroup> call({
    required String name,
    required String description,
  }) {
    final trimmedName = name.trim();
    final trimmedDescription = description.trim();
    if (trimmedName.isEmpty) {
      throw ArgumentError('모임명을 입력해주세요.');
    }
    return _repository.createGroup(
      name: trimmedName,
      description: trimmedDescription,
    );
  }
}
