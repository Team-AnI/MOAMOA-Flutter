import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/presentation/widgets/group_created_title.dart';

void main() {
  test('받침 없는 모임 이름에는 가를 붙인다', () {
    expect(groupCreatedTitle('스터디 모아'), '스터디 모아가 만들어졌어요');
  });
  test('받침 있는 모임 이름에는 이를 붙인다', () {
    expect(groupCreatedTitle('독서 모임'), '독서 모임이 만들어졌어요');
  });
}
