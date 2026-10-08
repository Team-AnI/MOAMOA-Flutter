import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/group.dart';

void main() {
  test('구성원 수가 없거나 0 이상이면 모임을 생성한다', () {
    for (final count in <int?>[null, 0, 1]) {
      final group = Group(
        id: 'g1',
        name: '모임',
        description: '',
        memberCount: count,
      );
      expect(group.memberCount, count);
    }
  });
  test('음수 구성원 수는 허용하지 않는다', () {
    final count = -1;
    expect(
      () => Group(id: 'g1', name: '모임', description: '', memberCount: count),
      throwsAssertionError,
    );
  });
}
