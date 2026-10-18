import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/usecases/no_params.dart';
import 'package:moamoa/features/group/domain/usecases/params/create_group_params.dart';
import 'package:moamoa/features/group/domain/usecases/params/get_group_params.dart';
import 'package:moamoa/features/group/domain/usecases/params/join_group_params.dart';

void main() {
  test('같은 입력은 값이 같고 다른 입력은 구분된다', () {
    const first = CreateGroupParams(name: '모임', description: '소개');
    const same = CreateGroupParams(name: '모임', description: '소개');
    const different = CreateGroupParams(name: '모임', description: '변경');
    expect(first, same);
    expect(first.hashCode, same.hashCode);
    expect(first, isNot(different));
    expect(
      const GetGroupParams(groupId: 1),
      isNot(const GetGroupParams(groupId: 2)),
    );
    expect(
      const JoinGroupParams(inviteCode: 'A'),
      isNot(const JoinGroupParams(inviteCode: 'B')),
    );
    expect(const NoParams(), const NoParams());
  });
}
