import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/settlement/domain/entities/settlement.dart';
import 'package:moamoa/features/settlement/presentation/regular_due_changes.dart';

const previous = RegularDue(
  id: 7,
  title: '월 회비',
  amount: 10000,
  cycle: DuesCycle.monthly,
  cycleDay: '10',
  sendTime: '09:00',
  dueDays: 7,
  bankName: '국민',
  accountNumber: '1234',
  accountHolder: '김모아',
  isActive: true,
  postNotice: false,
);
const input = RegularDueInput(
  title: '월 회비',
  amount: 10000,
  cycle: DuesCycle.monthly,
  cycleDay: '10',
  sendTime: '09:00',
  dueDays: 7,
  bankName: '국민',
  accountNumber: '1234',
  accountHolder: '김모아',
  postNotice: false,
);
void main() {
  test('변경이 없으면 PATCH와 이번 회차 적용 모두 보내지 않는다', () {
    expect(input.changesFrom(previous).isEmpty, isTrue);
  });
  test('활성 상태만 바꾸면 false를 누락하지 않는다', () {
    final changes = input.copyWith(isActive: false).changesFrom(previous);
    expect(changes.isActive, isFalse);
    expect(changes.title, isNull);
    expect(changes.amount, isNull);
  });
  test('주기를 바꾸면 청구일이 같은 문자열이어도 함께 전달한다', () {
    final changes = input
        .copyWith(cycle: DuesCycle.weekly, cycleDay: 'MON')
        .changesFrom(previous);
    expect(changes.cycle, DuesCycle.weekly);
    expect(changes.cycleDay, 'MON');
  });
  test('값 변경 없이 이번 회차 적용만 요청할 수 있다', () {
    final changes = input.changesFrom(previous, applyToCurrentSettlement: true);
    expect(changes.isEmpty, isFalse);
    expect(changes.title, isNull);
    expect(changes.applyToCurrentSettlement, isTrue);
  });
}
