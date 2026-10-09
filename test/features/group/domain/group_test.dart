import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/group.dart';

void main() {
  test('copyWith로 모임을 변경하면 원본을 보존하고 값 동등성을 유지한다', () {
    const original = Group(
      id: 1,
      name: '모임',
      description: '소개',
      memberCount: 2,
    );
    final updated = original.copyWith(name: '변경된 모임', description: null);

    expect(original.name, '모임');
    expect(original.description, '소개');
    expect(updated, const Group(id: 1, name: '변경된 모임', memberCount: 2));
    expect(
      updated.hashCode,
      const Group(id: 1, name: '변경된 모임', memberCount: 2).hashCode,
    );
    expect(() => original.copyWith(memberCount: -1), throwsAssertionError);
  });
  test('구성원 수가 없거나 0 이상이면 모임을 생성한다', () {
    for (final count in <int?>[null, 0, 1]) {
      final group = Group(
        id: 1,
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
      () => Group(id: 1, name: '모임', description: '', memberCount: count),
      throwsAssertionError,
    );
  });
}
