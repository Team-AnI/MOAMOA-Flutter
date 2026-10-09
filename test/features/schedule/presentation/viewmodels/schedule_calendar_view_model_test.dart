import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:moamoa/features/schedule/presentation/viewmodels/schedule_calendar_view_model.dart';

void main() {
  late ProviderContainer container;

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final thisMonth = DateTime(now.year, now.month);
  final nextMonth = DateTime(now.year, now.month + 1);

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
    // 화면이 구독하는 것처럼 상태를 유지한다. (autoDispose 라서 구독이 없으면 사라진다)
    container.listen(scheduleCalendarProvider, (_, _) {});
  });

  ScheduleCalendarState state() => container.read(scheduleCalendarProvider);

  test('처음에는 이번 달이 보이고 오늘이 선택되어 있다', () {
    expect(state().month, thisMonth);
    expect(state().selected, today);
  });

  test('다른 달로 바꾸면 그 달 1일이 선택된다', () {
    container.read(scheduleCalendarProvider.notifier).changeMonth(nextMonth);

    expect(state().month, nextMonth);
    expect(state().selected, nextMonth);
  });

  test('이번 달로 돌아오면 오늘이 선택된다', () {
    final viewModel = container.read(scheduleCalendarProvider.notifier);
    viewModel.changeMonth(nextMonth);

    viewModel.changeMonth(thisMonth);

    expect(state().month, thisMonth);
    expect(state().selected, today);
  });

  test('날짜를 선택하면 선택 날짜만 바뀐다', () {
    final date = DateTime(nextMonth.year, nextMonth.month, 10);
    final viewModel = container.read(scheduleCalendarProvider.notifier);
    viewModel.changeMonth(nextMonth);

    viewModel.select(date);

    expect(state().month, nextMonth);
    expect(state().selected, date);
  });
}
