// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_calendar_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 캘린더 탭의 월 이동과 날짜 선택을 관리합니다.
/// 목록 탭을 다녀와도 보던 달과 날짜가 유지되도록 ViewModel 에서 상태를 들고 있습니다.

@ProviderFor(ScheduleCalendarViewModel)
final scheduleCalendarViewModelProvider = ScheduleCalendarViewModelProvider._();

/// 캘린더 탭의 월 이동과 날짜 선택을 관리합니다.
/// 목록 탭을 다녀와도 보던 달과 날짜가 유지되도록 ViewModel 에서 상태를 들고 있습니다.
final class ScheduleCalendarViewModelProvider
    extends
        $NotifierProvider<ScheduleCalendarViewModel, ScheduleCalendarState> {
  /// 캘린더 탭의 월 이동과 날짜 선택을 관리합니다.
  /// 목록 탭을 다녀와도 보던 달과 날짜가 유지되도록 ViewModel 에서 상태를 들고 있습니다.
  ScheduleCalendarViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleCalendarViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleCalendarViewModelHash();

  @$internal
  @override
  ScheduleCalendarViewModel create() => ScheduleCalendarViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScheduleCalendarState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScheduleCalendarState>(value),
    );
  }
}

String _$scheduleCalendarViewModelHash() =>
    r'58ea417c5f6e440ac747f308eba01df304d9a390';

/// 캘린더 탭의 월 이동과 날짜 선택을 관리합니다.
/// 목록 탭을 다녀와도 보던 달과 날짜가 유지되도록 ViewModel 에서 상태를 들고 있습니다.

abstract class _$ScheduleCalendarViewModel
    extends $Notifier<ScheduleCalendarState> {
  ScheduleCalendarState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ScheduleCalendarState, ScheduleCalendarState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ScheduleCalendarState, ScheduleCalendarState>,
              ScheduleCalendarState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
