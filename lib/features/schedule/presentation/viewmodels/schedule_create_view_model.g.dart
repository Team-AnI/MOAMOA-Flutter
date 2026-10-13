// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_create_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 일정 만들기 ViewModel 입니다. [meetingId] 모임에 일정을 만들고 제출 과정을 [ScheduleCreateState] 로 알립니다.
///
/// autoDispose: 화면을 닫으면 이전 제출 결과(성공 id, 오류)가 남지 않게 초기화합니다.

@ProviderFor(ScheduleCreateViewModel)
final scheduleCreateViewModelProvider = ScheduleCreateViewModelFamily._();

/// 일정 만들기 ViewModel 입니다. [meetingId] 모임에 일정을 만들고 제출 과정을 [ScheduleCreateState] 로 알립니다.
///
/// autoDispose: 화면을 닫으면 이전 제출 결과(성공 id, 오류)가 남지 않게 초기화합니다.
final class ScheduleCreateViewModelProvider
    extends $NotifierProvider<ScheduleCreateViewModel, ScheduleCreateState> {
  /// 일정 만들기 ViewModel 입니다. [meetingId] 모임에 일정을 만들고 제출 과정을 [ScheduleCreateState] 로 알립니다.
  ///
  /// autoDispose: 화면을 닫으면 이전 제출 결과(성공 id, 오류)가 남지 않게 초기화합니다.
  ScheduleCreateViewModelProvider._({
    required ScheduleCreateViewModelFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'scheduleCreateViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$scheduleCreateViewModelHash();

  @override
  String toString() {
    return r'scheduleCreateViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ScheduleCreateViewModel create() => ScheduleCreateViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScheduleCreateState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScheduleCreateState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ScheduleCreateViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$scheduleCreateViewModelHash() =>
    r'4c465c9e42edcf10f05e1dcb1e088b3cf127744c';

/// 일정 만들기 ViewModel 입니다. [meetingId] 모임에 일정을 만들고 제출 과정을 [ScheduleCreateState] 로 알립니다.
///
/// autoDispose: 화면을 닫으면 이전 제출 결과(성공 id, 오류)가 남지 않게 초기화합니다.

final class ScheduleCreateViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ScheduleCreateViewModel,
          ScheduleCreateState,
          ScheduleCreateState,
          ScheduleCreateState,
          int
        > {
  ScheduleCreateViewModelFamily._()
    : super(
        retry: null,
        name: r'scheduleCreateViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 일정 만들기 ViewModel 입니다. [meetingId] 모임에 일정을 만들고 제출 과정을 [ScheduleCreateState] 로 알립니다.
  ///
  /// autoDispose: 화면을 닫으면 이전 제출 결과(성공 id, 오류)가 남지 않게 초기화합니다.

  ScheduleCreateViewModelProvider call(int meetingId) =>
      ScheduleCreateViewModelProvider._(argument: meetingId, from: this);

  @override
  String toString() => r'scheduleCreateViewModelProvider';
}

/// 일정 만들기 ViewModel 입니다. [meetingId] 모임에 일정을 만들고 제출 과정을 [ScheduleCreateState] 로 알립니다.
///
/// autoDispose: 화면을 닫으면 이전 제출 결과(성공 id, 오류)가 남지 않게 초기화합니다.

abstract class _$ScheduleCreateViewModel
    extends $Notifier<ScheduleCreateState> {
  late final _$args = ref.$arg as int;
  int get meetingId => _$args;

  ScheduleCreateState build(int meetingId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ScheduleCreateState, ScheduleCreateState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ScheduleCreateState, ScheduleCreateState>,
              ScheduleCreateState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
