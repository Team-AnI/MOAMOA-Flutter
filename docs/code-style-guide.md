# 코드 스타일 가이드라인

현재 확정된 기술 스택(Flutter, MVVM Feature-First + Layered Architecture, Dio, Riverpod[Inline], Stream + StreamProvider, flutter_secure_storage/shared_preferences, go_router, flutter_lints)을 기준으로 작성한 코드 컨벤션입니다. 기본 스타일은 [Effective Dart: Style](https://dart.dev/effective-dart/style)을 따르고, 프로젝트에 특화된 부분만 아래에 추가로 정의합니다.

## 1. 네이밍 규칙

> View(화면에 보이는 층)는 Page 와 Widget 두 가지로 구성됩니다. Page 는 라우트에 직접 연결되는 화면 단위, Widget 은 그 화면 안에서 쓰는 구성요소입니다.

**파일명**: snake_case + 역할 접미사

| 역할 | 파일명 예시 |
| --- | --- |
| 화면(페이지) | `schedule_list_page.dart` |
| 하위 위젯 | `schedule_card.dart` |
| ViewModel | `schedule_list_view_model.dart` |
| Provider 모음 | `schedule_providers.dart` |
| UseCase | `get_schedules.dart` |
| Repository 인터페이스 | `schedule_repository.dart` |
| Repository 구현체 | `schedule_repository_impl.dart` |
| DataSource 인터페이스 | `schedule_remote_data_source.dart` |
| DataSource 구현체 | `schedule_remote_data_source_impl.dart` |
| Entity (domain) | `schedule.dart` |
| Model (data) | `schedule_model.dart` |

**클래스명**: PascalCase

- View — Page: `ScheduleListPage` (라우트에 연결되는 화면)
- View — Widget: `ScheduleCard` — 다른 파일에서 재사용하지 않는 내부 전용 위젯은 `_ScheduleCard`처럼 언더스코어(private)로 작성
- ViewModel: `ScheduleListViewModel`
- UseCase: `GetSchedules`
- Repository: `ScheduleRepository`(인터페이스) / `ScheduleRepositoryImpl`(구현체)
- DataSource: `ScheduleRemoteDataSource`(인터페이스) / `ScheduleRemoteDataSourceImpl`(구현체)
- Entity: `Schedule`
- Model: `ScheduleModel`

**변수/함수명**: camelCase

**Provider 변수명**: 역할과 상관없이 반드시 `xxxProvider`로 끝냅니다.

**Riverpod 작성 방식**: `@riverpod` 코드젠 애노테이션은 사용하지 않고, 아래처럼 수동(Inline)으로 선언합니다. `core/`(dio, apiClient, secureStorage 등) 레벨 Provider도 예외 없이 동일하게 Inline으로 작성합니다.

```dart
// core/network/dio_provider.dart — core 레벨 Provider 예시
final dioProvider = Provider<Dio>((ref) => buildDio());

// core/network/api_client.dart
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient(ref.watch(dioProvider)));

// features/schedule/presentation/providers/schedule_providers.dart — feature 레벨 Provider 예시
final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => ScheduleRepositoryImpl(ref.watch(scheduleRemoteDataSourceProvider)),
);
final scheduleListProvider =
    AsyncNotifierProvider<ScheduleListViewModel, List<Schedule>>(ScheduleListViewModel.new);
```

**계층별 예시 코드 (schedule 기능 기준)**

위 네이밍 규칙을 실제 코드에 적용하면 아래와 같은 흐름이 됩니다. (Entity → Model → DataSource → Repository → UseCase → ViewModel → Provider → View[Page/Widget])

```dart
// Entity (domain/entities/schedule.dart)
// - 순수 도메인 모델. data/presentation 계층에 의존하지 않습니다.
class Schedule {
  const Schedule({required this.id, required this.title, required this.date});

  final int id;
  final String title;
  final DateTime date;
}
```

```dart
// Model (data/models/schedule_model.dart)
// - 서버 응답(JSON)을 그대로 담는 모델. Entity 로 변환하는 역할까지 포함합니다.
class ScheduleModel {
  const ScheduleModel({required this.id, required this.title, required this.date});

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] as int,
      title: json['title'] as String,
      date: json['date'] as String,
    );
  }

  final int id;
  final String title;
  final String date;

  Schedule toEntity() => Schedule(id: id, title: title, date: DateTime.parse(date));
}
```

> 서버로 데이터를 보내야 하는 경우(POST/PUT 요청 등)에는 Model 에 `toJson()`도 함께 추가합니다. 위 예시는 조회(GET)만 다루므로 생략했습니다.

```dart
// DataSource (data/datasources/schedule_remote_data_source.dart, schedule_remote_data_source_impl.dart)
// - 실제 API 호출만 담당합니다. 변환/비즈니스 로직은 넣지 않습니다.
abstract interface class ScheduleRemoteDataSource {
  Future<List<ScheduleModel>> fetchSchedules();
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  const ScheduleRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<ScheduleModel>> fetchSchedules() async {
    final response = await _apiClient.get<List<dynamic>>('/schedules');
    return (response.data ?? [])
        .map((json) => ScheduleModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
```

```dart
// Repository (domain/repositories/schedule_repository.dart, data/repositories/schedule_repository_impl.dart)
// - DataSource 를 묶어 도메인에서 쓸 Entity 로 변환해 내려줍니다.
abstract interface class ScheduleRepository {
  Future<List<Schedule>> getSchedules();
}

class ScheduleRepositoryImpl implements ScheduleRepository {
  const ScheduleRepositoryImpl({required this._remoteDataSource});

  final ScheduleRemoteDataSource _remoteDataSource;

  @override
  Future<List<Schedule>> getSchedules() async {
    final response = await _remoteDataSource.fetchSchedules();
    return response.map((model) => model.toEntity()).toList();
  }
}
```

```dart
// UseCase (domain/usecases/get_schedules.dart)
// - Repository 호출 1개 이상을 조합하는 단위. 파라미터가 필요하면 Params 를 통해 받습니다.

// 파라미터 공통 추상 클래스
abstract class Params {
  const Params();
}

// 파라미터가 필요 없는 UseCase에서 사용
final class NoParams extends Params {
  const NoParams();
}

// UseCase 공통 추상 클래스
abstract class Usecase<Result, P extends Params> {
  Future<Result> call(P params);
}

// GetSchedules 전용 파라미터
final class GetSchedulesParams extends Params {
  const GetSchedulesParams({
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;
}

// 테스트에서 Mock/Fake로 대체하기 위한 추상 클래스
abstract class GetSchedules extends Usecase<List<Schedule>, GetSchedulesParams> {}

// 실제 구현 클래스
final class GetSchedulesImpl implements GetSchedules {
  GetSchedulesImpl({required this._repository});

  final ScheduleRepository _repository;

  @override
  Future<List<Schedule>> call(GetSchedulesParams params) {
    return _repository.getSchedules(
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

// 파라미터가 필요 없는 UseCase 예시
abstract class GetAllSchedules extends Usecase<List<Schedule>, NoParams> {}

final class GetAllSchedulesImpl implements GetAllSchedules {
  GetAllSchedulesImpl({required this._repository});

  final ScheduleRepository _repository;

  @override
  Future<List<Schedule>> call(NoParams params) {
    return _repository.getAllSchedules();
  }
}
```

```dart
// ViewModel (presentation/viewmodels/schedule_list_view_model.dart)
// - UseCase 를 호출하고 화면에서 쓸 상태(AsyncValue)를 들고 있습니다.
// - Riverpod 의 AsyncNotifier 를 상속하지만, 클래스/파일 명명은 Notifier 가 아닌 ViewModel 을 사용합니다.
class ScheduleListViewModel extends AsyncNotifier<List<Schedule>> {
  @override
  Future<List<Schedule>> build() => ref.watch(getSchedulesProvider).call();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(getSchedulesProvider).call());
  }
}
```

```dart
// Provider 모음 (presentation/providers/schedule_providers.dart)
// - 계층별 객체를 Riverpod 에 등록합니다. 아래로 갈수록 상위 계층이 하위 계층을 watch 합니다.
final scheduleRemoteDataSourceProvider = Provider<ScheduleRemoteDataSource>(
  (ref) => ScheduleRemoteDataSourceImpl(apiClient: ref.watch(apiClientProvider)),
);

final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => ScheduleRepositoryImpl(ref.watch(scheduleRemoteDataSourceProvider)),
);

final getSchedulesProvider = Provider<GetSchedules>(
  (ref) => GetSchedules(ref.watch(scheduleRepositoryProvider)),
);

final scheduleListProvider =
    AsyncNotifierProvider<ScheduleListViewModel, List<Schedule>>(ScheduleListViewModel.new);
```

```dart
// View — Page (presentation/pages/schedule_list_page.dart)
// - ViewModel 을 watch 해서 화면을 그립니다. 비즈니스 로직은 두지 않습니다.
class ScheduleListPage extends ConsumerWidget {
  const ScheduleListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedules = ref.watch(scheduleListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('일정')),
      body: schedules.when(
        data: (list) => ListView(
          children: list.map((s) => _ScheduleCard(schedule: s)).toList(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
      ),
    );
  }
}

// View — Widget (같은 화면에서만 쓰면 같은 파일에 private 로 둡니다. 2번 파일 구성 규칙 참고)
class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({required this.schedule});

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(schedule.title),
            Text(schedule.date.toString()),
          ],
        ),
      ),
    );
  }
}
```

## 2. 파일 구성 규칙

> 전체 폴더 구조(Feature-First + Layered Architecture)는 [프로젝트 아키텍처](../README.md#프로젝트-아키텍처) 섹션을 따릅니다. 여기서는 그 구조 안에서 파일을 나누는 기준만 정의합니다.

- **위젯 분리 기준**: `build()` 내부가 3~4 depth 이상 중첩되거나 50줄을 넘으면 별도 위젯 클래스로 분리합니다. 그 화면에서만 쓰는 위젯은 private(`_`) 클래스로 같은 파일에, 다른 화면에서도 재사용하는 위젯은 `widgets/` 폴더에 public 클래스로 둡니다.
- 파일 하나에는 public 클래스 1개만 둡니다 (private 헬퍼 위젯/클래스는 예외).

다른 화면에서도 재사용한다면 `_ScheduleCard` 대신 `ScheduleCard`로 public 클래스를 만들고 `widgets/schedule_card.dart`로 옮깁니다.

## 3. import 순서

1. `dart:` core 라이브러리
2. `package:` 라이브러리 (Flutter SDK, 외부 패키지, 프로젝트 패키지 포함, 알파벳순)
3. 상대 경로 import (사용하는 경우)

각 그룹 사이는 빈 줄 한 줄로 구분합니다.

```dart
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/schedule/domain/entities/schedule.dart';
```

## 4. lint 규칙 (`analysis_options.yaml`)

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_single_quotes: true
    always_declare_return_types: true
    avoid_print: true
    prefer_const_constructors: true
    sort_child_properties_last: true
```

필요한 규칙은 `linter.rules` 아래에 팀 논의 후 추가합니다.