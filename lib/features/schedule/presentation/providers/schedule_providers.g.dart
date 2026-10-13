// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// TODO: API 연동 시 실제 API 를 호출하는 구현체로 교체합니다.
/// 그 전까지는 override 하지 않으면 읽을 수 없습니다. (테스트는 Fake 를 주입)

@ProviderFor(scheduleRepository)
final scheduleRepositoryProvider = ScheduleRepositoryProvider._();

/// TODO: API 연동 시 실제 API 를 호출하는 구현체로 교체합니다.
/// 그 전까지는 override 하지 않으면 읽을 수 없습니다. (테스트는 Fake 를 주입)

final class ScheduleRepositoryProvider
    extends
        $FunctionalProvider<
          ScheduleRepository,
          ScheduleRepository,
          ScheduleRepository
        >
    with $Provider<ScheduleRepository> {
  /// TODO: API 연동 시 실제 API 를 호출하는 구현체로 교체합니다.
  /// 그 전까지는 override 하지 않으면 읽을 수 없습니다. (테스트는 Fake 를 주입)
  ScheduleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleRepositoryHash();

  @$internal
  @override
  $ProviderElement<ScheduleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ScheduleRepository create(Ref ref) {
    return scheduleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScheduleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScheduleRepository>(value),
    );
  }
}

String _$scheduleRepositoryHash() =>
    r'ed2065c99ed4af56e848af1d91a93f455db594a6';

@ProviderFor(createSchedule)
final createScheduleProvider = CreateScheduleProvider._();

final class CreateScheduleProvider
    extends $FunctionalProvider<CreateSchedule, CreateSchedule, CreateSchedule>
    with $Provider<CreateSchedule> {
  CreateScheduleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createScheduleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createScheduleHash();

  @$internal
  @override
  $ProviderElement<CreateSchedule> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CreateSchedule create(Ref ref) {
    return createSchedule(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateSchedule value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateSchedule>(value),
    );
  }
}

String _$createScheduleHash() => r'97ee1c1c5232620e4471e45e65eebdc4a88d8671';

@ProviderFor(getSchedules)
final getSchedulesProvider = GetSchedulesProvider._();

final class GetSchedulesProvider
    extends $FunctionalProvider<GetSchedules, GetSchedules, GetSchedules>
    with $Provider<GetSchedules> {
  GetSchedulesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSchedulesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSchedulesHash();

  @$internal
  @override
  $ProviderElement<GetSchedules> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetSchedules create(Ref ref) {
    return getSchedules(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSchedules value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSchedules>(value),
    );
  }
}

String _$getSchedulesHash() => r'0b3cee4493c9843fcfd053bfeb65a63b87435d8a';

@ProviderFor(getSchedule)
final getScheduleProvider = GetScheduleProvider._();

final class GetScheduleProvider
    extends $FunctionalProvider<GetSchedule, GetSchedule, GetSchedule>
    with $Provider<GetSchedule> {
  GetScheduleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getScheduleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getScheduleHash();

  @$internal
  @override
  $ProviderElement<GetSchedule> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetSchedule create(Ref ref) {
    return getSchedule(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSchedule value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSchedule>(value),
    );
  }
}

String _$getScheduleHash() => r'bba41c8c7b209daddd87427f2e42ea0b3b8e3d16';

/// 현재 사용자가 이 모임의 관리자인지 알려줍니다.
/// 권한 정보가 연동되기 전에는 관리자가 아닌 것으로 보고 일정 만들기 버튼을 숨깁니다.
/// TODO(#29): 모임 상세 응답의 myRole 로 교체합니다.

@ProviderFor(scheduleAdmin)
final scheduleAdminProvider = ScheduleAdminProvider._();

/// 현재 사용자가 이 모임의 관리자인지 알려줍니다.
/// 권한 정보가 연동되기 전에는 관리자가 아닌 것으로 보고 일정 만들기 버튼을 숨깁니다.
/// TODO(#29): 모임 상세 응답의 myRole 로 교체합니다.

final class ScheduleAdminProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// 현재 사용자가 이 모임의 관리자인지 알려줍니다.
  /// 권한 정보가 연동되기 전에는 관리자가 아닌 것으로 보고 일정 만들기 버튼을 숨깁니다.
  /// TODO(#29): 모임 상세 응답의 myRole 로 교체합니다.
  ScheduleAdminProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleAdminProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleAdminHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return scheduleAdmin(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$scheduleAdminHash() => r'b7e9cb2e76513d0390fa4737e09157fc3282cbf4';
