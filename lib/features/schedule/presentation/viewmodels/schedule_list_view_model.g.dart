// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_list_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 기간 내 일정 목록(시작 일시 오름차순)

@ProviderFor(ScheduleListViewModel)
final scheduleListViewModelProvider = ScheduleListViewModelFamily._();

/// 기간 내 일정 목록(시작 일시 오름차순)
final class ScheduleListViewModelProvider
    extends $AsyncNotifierProvider<ScheduleListViewModel, List<Schedule>> {
  /// 기간 내 일정 목록(시작 일시 오름차순)
  ScheduleListViewModelProvider._({
    required ScheduleListViewModelFamily super.from,
    required ({int meetingId, DateTime startDate, DateTime endDate})
    super.argument,
  }) : super(
         retry: null,
         name: r'scheduleListViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$scheduleListViewModelHash();

  @override
  String toString() {
    return r'scheduleListViewModelProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ScheduleListViewModel create() => ScheduleListViewModel();

  @override
  bool operator ==(Object other) {
    return other is ScheduleListViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$scheduleListViewModelHash() =>
    r'4b1b4829ec742334b144d660cca4aa3d39d9ef83';

/// 기간 내 일정 목록(시작 일시 오름차순)

final class ScheduleListViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ScheduleListViewModel,
          AsyncValue<List<Schedule>>,
          List<Schedule>,
          FutureOr<List<Schedule>>,
          ({int meetingId, DateTime startDate, DateTime endDate})
        > {
  ScheduleListViewModelFamily._()
    : super(
        retry: null,
        name: r'scheduleListViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// 기간 내 일정 목록(시작 일시 오름차순)

  ScheduleListViewModelProvider call({
    required int meetingId,
    required DateTime startDate,
    required DateTime endDate,
  }) => ScheduleListViewModelProvider._(
    argument: (meetingId: meetingId, startDate: startDate, endDate: endDate),
    from: this,
  );

  @override
  String toString() => r'scheduleListViewModelProvider';
}

/// 기간 내 일정 목록(시작 일시 오름차순)

abstract class _$ScheduleListViewModel extends $AsyncNotifier<List<Schedule>> {
  late final _$args =
      ref.$arg as ({int meetingId, DateTime startDate, DateTime endDate});
  int get meetingId => _$args.meetingId;
  DateTime get startDate => _$args.startDate;
  DateTime get endDate => _$args.endDate;

  FutureOr<List<Schedule>> build({
    required int meetingId,
    required DateTime startDate,
    required DateTime endDate,
  });
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Schedule>>, List<Schedule>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Schedule>>, List<Schedule>>,
              AsyncValue<List<Schedule>>,
              Object?,
              Object?
            >;
    return element.handleCreate(
      ref,
      () => build(
        meetingId: _$args.meetingId,
        startDate: _$args.startDate,
        endDate: _$args.endDate,
      ),
    );
  }
}
