// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 일정 한 건의 상세 정보

@ProviderFor(ScheduleDetailViewModel)
final scheduleDetailViewModelProvider = ScheduleDetailViewModelFamily._();

/// 일정 한 건의 상세 정보
final class ScheduleDetailViewModelProvider
    extends $AsyncNotifierProvider<ScheduleDetailViewModel, Schedule> {
  /// 일정 한 건의 상세 정보
  ScheduleDetailViewModelProvider._({
    required ScheduleDetailViewModelFamily super.from,
    required ({int meetingId, int scheduleId}) super.argument,
  }) : super(
         retry: null,
         name: r'scheduleDetailViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$scheduleDetailViewModelHash();

  @override
  String toString() {
    return r'scheduleDetailViewModelProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ScheduleDetailViewModel create() => ScheduleDetailViewModel();

  @override
  bool operator ==(Object other) {
    return other is ScheduleDetailViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$scheduleDetailViewModelHash() =>
    r'fed2a361b6fb36eeb12e26eb07da265ebabdd595';

/// 일정 한 건의 상세 정보

final class ScheduleDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ScheduleDetailViewModel,
          AsyncValue<Schedule>,
          Schedule,
          FutureOr<Schedule>,
          ({int meetingId, int scheduleId})
        > {
  ScheduleDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'scheduleDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// 일정 한 건의 상세 정보

  ScheduleDetailViewModelProvider call({
    required int meetingId,
    required int scheduleId,
  }) => ScheduleDetailViewModelProvider._(
    argument: (meetingId: meetingId, scheduleId: scheduleId),
    from: this,
  );

  @override
  String toString() => r'scheduleDetailViewModelProvider';
}

/// 일정 한 건의 상세 정보

abstract class _$ScheduleDetailViewModel extends $AsyncNotifier<Schedule> {
  late final _$args = ref.$arg as ({int meetingId, int scheduleId});
  int get meetingId => _$args.meetingId;
  int get scheduleId => _$args.scheduleId;

  FutureOr<Schedule> build({required int meetingId, required int scheduleId});
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Schedule>, Schedule>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Schedule>, Schedule>,
              AsyncValue<Schedule>,
              Object?,
              Object?
            >;
    return element.handleCreate(
      ref,
      () => build(meetingId: _$args.meetingId, scheduleId: _$args.scheduleId),
    );
  }
}
