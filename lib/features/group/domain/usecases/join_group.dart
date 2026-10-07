import '../entities/current_group.dart';
import '../repositories/group_repository.dart';

class JoinGroup {
  const JoinGroup(this._repository);
  final GroupRepository _repository;

  Future<CurrentGroup> call({required String inviteCode}) {
    final code = inviteCode.trim();
    if (code.isEmpty) throw ArgumentError('초대 코드를 입력해주세요.');
    return _repository.joinGroup(inviteCode: code);
  }
}
