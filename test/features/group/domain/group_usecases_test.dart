import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/group_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';
import 'package:moamoa/features/group/domain/usecases/create_group.dart';
import 'package:moamoa/features/group/domain/usecases/get_group_invite_code.dart';
import 'package:moamoa/features/group/domain/usecases/join_group.dart';

import '../fake_group_repository.dart';

void main() {
  test('빈 이름은 저장소 호출 전에 거부한다', () {
    final repository = FakeGroupRepository();
    final create = CreateGroup(repository);
    expect(() => create(name: '', description: '소개'), throwsArgumentError);

    expect(repository.createCalls, 0);
  });

  test('소개 없이도 모임을 생성할 수 있다', () async {
    final repository = FakeGroupRepository();
    repository.pendingCreate.complete(makeGroup(GroupRole.admin));
    await CreateGroup(repository)(name: '이름', description: '  ');
    expect(repository.lastDescription, '');
    expect(repository.createCalls, 1);
  });

  test('빈 초대 코드는 거부한다', () {
    expect(
      () => JoinGroup(FakeGroupRepository())(inviteCode: ' '),
      throwsArgumentError,
    );
  });

  test('일반 구성원은 초대 코드를 요청할 수 없다', () {
    expect(
      () => GetGroupInviteCode(FakeGroupRepository())(
        makeGroup(GroupRole.member),
      ),
      throwsA(
        isA<GroupFailure>().having(
          (failure) => failure.reason,
          'reason',
          GroupFailureReason.forbidden,
        ),
      ),
    );
  });

  test('관리자는 초대 코드를 조회한다', () async {
    expect(
      await GetGroupInviteCode(FakeGroupRepository())(
        makeGroup(GroupRole.admin),
      ),
      'CODE',
    );
  });
}
