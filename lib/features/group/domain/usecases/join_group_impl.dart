import '../entities/current_group.dart';
import '../repositories/group_repository.dart';
import 'join_group.dart';
import 'params/join_group_params.dart';

final class JoinGroupImpl implements JoinGroup {
  const JoinGroupImpl({required this.repository});
  final GroupRepository repository;
  @override
  Future<CurrentGroup> call(JoinGroupParams params) {
    final code = params.inviteCode.trim();
    if (code.isEmpty) throw ArgumentError('초대 코드를 입력해주세요.');
    return repository.joinGroup(inviteCode: code);
  }
}
