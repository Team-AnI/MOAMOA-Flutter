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

**Riverpod 작성 방식**: `@riverpod` 코드젠 애노테이션은 사용하지 않고, 아래처럼 수동(Inline)으로 선언합니다. `core/`(dio, secureStorage 등) 레벨 Provider도 예외 없이 동일하게 Inline으로 작성합니다. (현재 `core/`에 남아 있는 `@riverpod` 코드는 Inline 으로 전환하고 `.g.dart` 를 삭제합니다.)

```dart
// core/network/dio_provider.dart — core 레벨 Provider 예시
final dioProvider = Provider<Dio>((ref) => buildDio());

// features/schedule/presentation/providers/schedule_providers.dart — feature 레벨 Provider 예시
final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => ScheduleRepositoryImpl(scheduleRemoteDataSource: ref.watch(scheduleRemoteDataSourceProvider)),
);
final scheduleListProvider =
    AsyncNotifierProvider<ScheduleListViewModel, List<Schedule>>(ScheduleListViewModel.new);
```

**계층별 예시 코드 (schedule 기능 기준)**

위 네이밍 규칙을 실제 코드에 적용하면 아래와 같은 흐름이 됩니다. (Entity → Model → DataSource → Repository → UseCase → ViewModel → Provider → View[Page/Widget])

```dart
// Entity (domain/entities/schedule.dart)
// - 순수 도메인 모델. data/presentation 계층에 의존하지 않습니다.
// - freezed 로 작성합니다. (2-4 참고)
part 'schedule.freezed.dart';

@freezed
abstract class Schedule with _$Schedule {
  const factory Schedule({
    required int id,
    required String title,
    required DateTime date,
  }) = _Schedule;
}
```

```dart
// Model (data/models/schedule_model.dart)
// - 서버 응답(JSON)을 그대로 담는 모델. freezed + json_serializable 로 작성합니다.
part 'schedule_model.freezed.dart';
part 'schedule_model.g.dart';

@freezed
abstract class ScheduleModel with _$ScheduleModel {
  const factory ScheduleModel({
    required int id,
    required String title,
    required String date,
  }) = _ScheduleModel;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);
}

// Entity 변환은 extension 으로 둡니다.
extension ScheduleModelX on ScheduleModel {
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
  const ScheduleRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<ScheduleModel>> fetchSchedules() async {
    final response = await _dio.get<List<dynamic>>('/schedules');
    return (response.data ?? [])
        .whereType<Map<String, dynamic>>()
        .map(ScheduleModel.fromJson)
        .toList();
  }
}
```

```dart
// Repository (domain/repositories/schedule_repository.dart, data/repositories/schedule_repository_impl.dart)
// - DataSource 를 묶어 도메인에서 쓸 Entity 로 변환해 내려줍니다.
abstract interface class ScheduleRepository {
  Future<List<Schedule>> getSchedules({
    required DateTime startDate,
    required DateTime endDate,
  });
  Future<List<Schedule>> getAllSchedules();
}

class ScheduleRepositoryImpl implements ScheduleRepository {
  const ScheduleRepositoryImpl({required ScheduleRemoteDataSource scheduleRemoteDataSource})
      : _scheduleRemoteDataSource = scheduleRemoteDataSource;

  final ScheduleRemoteDataSource _scheduleRemoteDataSource;

  @override
  Future<List<Schedule>> getSchedules({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response = await _scheduleRemoteDataSource.fetchSchedules();
    return response.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Schedule>> getAllSchedules() async {
    final response = await _scheduleRemoteDataSource.fetchSchedules();
    return response.map((model) => model.toEntity()).toList();
  }
}
```

```dart
// UseCase (domain/usecases/get_schedules.dart)
// - Repository 호출 1개 이상을 조합하는 단위. 파라미터가 필요하면 Params 를 통해 받습니다.

// Params / NoParams / Usecase 는 공통 코드이므로 core/usecases/ 에 한 번만 정의하고 import 합니다.
// (feature 마다 복사해 두지 않습니다)
import 'package:moamoa/core/usecases/no_params.dart';
import 'package:moamoa/core/usecases/params.dart';
import 'package:moamoa/core/usecases/usecase.dart';

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
  GetSchedulesImpl({required ScheduleRepository scheduleRepository})
      : _scheduleRepository = scheduleRepository;

  final ScheduleRepository _scheduleRepository;

  @override
  Future<List<Schedule>> call(GetSchedulesParams params) {
    return _scheduleRepository.getSchedules(
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

// 파라미터가 필요 없는 UseCase 예시
abstract class GetAllSchedules extends Usecase<List<Schedule>, NoParams> {}

final class GetAllSchedulesImpl implements GetAllSchedules {
  GetAllSchedulesImpl({required ScheduleRepository scheduleRepository})
      : _scheduleRepository = scheduleRepository;

  final ScheduleRepository _scheduleRepository;

  @override
  Future<List<Schedule>> call(NoParams params) {
    return _scheduleRepository.getAllSchedules();
  }
}
```

```dart
// ViewModel (presentation/viewmodels/schedule_list_view_model.dart)
// - UseCase 를 호출하고 화면에서 쓸 상태(AsyncValue)를 들고 있습니다.
// - Riverpod 의 AsyncNotifier 를 상속하지만, 클래스/파일 명명은 Notifier 가 아닌 ViewModel 을 사용합니다.
class ScheduleListViewModel extends AsyncNotifier<List<Schedule>> {
  @override
  Future<List<Schedule>> build() => _fetch(ref.watch(getSchedulesProvider));

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetch(ref.read(getSchedulesProvider)));
  }

  Future<List<Schedule>> _fetch(GetSchedules getSchedules) {
    final now = DateTime.now();
    return getSchedules(
      GetSchedulesParams(
        startDate: now,
        endDate: now.add(const Duration(days: 7)),
      ),
    );
  }
}
```

```dart
// Provider 모음 (presentation/providers/schedule_providers.dart)
// - 계층별 객체를 Riverpod 에 등록합니다. 아래로 갈수록 상위 계층이 하위 계층을 watch 합니다.
final scheduleRemoteDataSourceProvider = Provider<ScheduleRemoteDataSource>(
  (ref) => ScheduleRemoteDataSourceImpl(dio: ref.watch(dioProvider)),
);

final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => ScheduleRepositoryImpl(scheduleRemoteDataSource: ref.watch(scheduleRemoteDataSourceProvider)),
);

final getSchedulesProvider = Provider<GetSchedules>(
  (ref) => GetSchedulesImpl(scheduleRepository: ref.watch(scheduleRepositoryProvider)),
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
        error: (e, _) => Center(
          child: Text(e is ScheduleException ? e.message : '일시적인 오류가 발생했어요.'),
        ),
      ),
    );
  }
}

// View — Widget (같은 화면에서만 쓰면 같은 파일에 private 로 둡니다. 3번 파일 구성 규칙 참고)
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

## 2. 작성 규칙

### 2-1. 생성자와 의존성 주입

의존성은 이름 있는 `required` 파라미터로 받고, 초기화 리스트로 private 필드에 대입합니다. 모든 계층(DataSource, Repository, UseCase, ViewModel)에 동일하게 적용합니다.

```dart
const NoticeRepositoryImpl({required NoticeRemoteDataSource noticeRemoteDataSource})
    : _noticeRemoteDataSource = noticeRemoteDataSource;
```

- 파라미터 이름은 타입을 드러내는 이름을 씁니다 (`repository` ✕ → `noticeRepository` ○).
- 이 형태는 `prefer_initializing_formals` 린트와 충돌하므로 해당 규칙을 해제합니다 (5. lint 규칙 참고).

### 2-2. family(인자를 받는) ViewModel

> 이슈 #51 의 제안(wjddns0122)입니다. 팀 확정 전까지 "제안" 으로 둡니다.

- `family` 키는 값 객체로 받습니다. 인자가 여러 개일 때는 요청 클래스(freezed) 또는 이름 있는 record(`typedef NoticeDetailArgs = ({int meetingId, int noticeId});`)로 묶습니다.
- ViewModel 은 키 객체를 받지 않고, Provider 정의에서 값을 꺼내 **named 값**으로 생성자에 넘깁니다.

```dart
// domain/entities/schedule_list_request.dart
@freezed
abstract class ScheduleListRequest with _$ScheduleListRequest {
  const factory ScheduleListRequest({
    required int meetingId,
    required DateTime startDate,
    required DateTime endDate,
  }) = _ScheduleListRequest;
}

// presentation/providers/schedule_providers.dart
final scheduleListProvider =
    AsyncNotifierProvider.family<
      ScheduleListViewModel,
      List<Schedule>,
      ScheduleListRequest
    >(
      (request) => ScheduleListViewModel(
        meetingId: request.meetingId,
        startDate: request.startDate,
        endDate: request.endDate,
      ),
    );
```

### 2-3. 예외 처리

> 이슈 #50 은 아직 결정되지 않았습니다. 아래는 공지(notice)에서 쓰는 현재 방식이며, 확정 규칙이 아닙니다.

현재 방식 (참고)

- `DioException` 은 Repository 구현체의 `_guard` 에서 잡아 도메인 예외로 바꿔 던집니다. UseCase, ViewModel, 화면은 `DioException` 을 알지 못합니다.
- 서버 실패 응답의 `error.message` 를 사용자 메시지로 쓰고, 응답 자체가 없으면(연결 실패 등) 공통 문구를 씁니다.
- 화면에는 `'오류: $e'` 처럼 예외 객체를 출력하지 않고 메시지만 보여줍니다.

팀 결정이 필요한 항목

- 공통 예외 타입과 변환 함수를 `core/` 로 옮길지, feature 별로 둘지
- 오류 코드, HTTP 상태, 네트워크 오류 처리 규칙

### 2-4. Model / Entity / Request

- Entity, Model, Request, State 는 `freezed` 로 작성합니다 (불변 + `==`/`copyWith` 자동 생성).
- Model → Entity 변환은 `extension NoticeModelX { Notice toEntity() }` 로 둡니다.
- DataSource 메서드의 인자는 `XxxRequest` DTO 로 받습니다. 경로 변수(`meetingId` 등)는 `@JsonKey(includeToJson: false)` 로 본문에서 뺍니다. 일부만 보내는 수정 요청은 `@JsonKey(includeIfNull: false)` 를 씁니다.
- 팀 결정 필요: Repository 인터페이스가 낱개 인자를 받을지, UseCase 의 `XxxParams` 를 받을지는 아직 정해지지 않았습니다.

## 3. 파일 구성 규칙

> 전체 폴더 구조(Feature-First + Layered Architecture)는 프로젝트 README 의 아키텍처 섹션을 따릅니다. (README 에 해당 섹션이 작성되면 링크로 교체) 여기서는 그 구조 안에서 파일을 나누는 기준만 정의합니다.

- **위젯 분리 기준**: `build()` 내부가 3~4 depth 이상 중첩되거나 50줄을 넘으면 별도 위젯 클래스로 분리합니다. 그 화면에서만 쓰는 위젯은 private(`_`) 클래스로 같은 파일에, 다른 화면에서도 재사용하는 위젯은 `widgets/` 폴더에 public 클래스로 둡니다.
- 파일 하나에는 public 클래스 1개만 둡니다. 예외: private 헬퍼 위젯/클래스, 그리고 한 UseCase 파일 안의 `XxxParams` / 추상 `Xxx` / `XxxImpl` 세트(아래 UseCase 예시).

다른 화면에서도 재사용한다면 `_ScheduleCard` 대신 `ScheduleCard`로 public 클래스를 만들고 `widgets/schedule_card.dart`로 옮깁니다.

## 4. import 순서

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

## 5. lint 규칙 (`analysis_options.yaml`)

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_single_quotes: true
    always_declare_return_types: true
    avoid_print: true
    prefer_const_constructors: true
    sort_child_properties_last: true
    prefer_initializing_formals: false
```

`prefer_initializing_formals` 는 해제합니다. 이 가이드의 생성자 형태(`const Foo({required Dio dio}) : _dio = dio;`)는 SDK 3.12 부터 이 규칙에 걸립니다. 파라미터 이름이 필드 이름에서 `_` 만 뺀 것과 같고 값을 그대로 대입하면 걸리는데, 이 형태가 모든 계층(DataSource, Repository, UseCase, ViewModel)의 표준이라 규칙 쪽을 해제합니다. (#46 → #53)

필요한 규칙은 `linter.rules` 아래에 팀 논의 후 추가합니다.

## 6. 테스트 설명 작성 컨벤션 (제안)

관련 이슈: [#45](https://github.com/Team-AnI/MOAMOA-Flutter/issues/45).
아래 규칙은 팀 리뷰를 위한 제안입니다. 승인 후 확정된 기준으로 적용합니다.
테스트가 검증하는 동작을 설명하며, API의 미확정 정책을 이 문서로 확정하지 않습니다.

### 6-1. `test` / `testWidgets` 설명

- 한국어로 작성하고, 문장은 `~한다`, `~된다`처럼 기대 결과로 끝냅니다.
- 기본 형식은 **조건 + 행동 + 기대 결과**입니다. 맥락상 분명한 조건·행동은 생략할 수 있습니다.
- 입력·상태와 관찰 가능한 결과가 드러나도록 작성합니다.
- `정상 동작`, `성공 테스트`, `테스트 1` 같은 모호한 이름은 사용하지 않습니다.
- `given/when/then`, `[정상]` 같은 접두사는 필수로 붙이지 않습니다.
- 하나의 설명에는 하나의 동작을 담습니다. 같은 동작에 대한 여러 assertion은 허용합니다.
- 동작 대신 private 함수 이름이나 구현 순서만 나열하지 않습니다.
- `testWidgets`는 누르기·입력·화면 표시처럼 사용자 관점의 행동과 결과를 우선 표현합니다.
- 초기 렌더링·접근성·공개 위젯 계약을 검증할 때는 사용자 조작을 억지로 넣지 않고 해당 조건과 관찰 가능한 결과를 적습니다.
- 오류를 검증하는 설명은 실제 동작에 따라 구분합니다. 오류 값을 반환하면 `검증 오류를 반환한다`, 예외를 던지면 `검증 예외가 발생한다`, ViewModel 상태를 변경하면 `오류 상태가 된다`로 표현합니다. 예외 발생을 오류 반환이라고 쓰지 않습니다.

```dart
// 정상 동작
test('역할이 관리자이면 초대 코드 조회를 허용한다', () async {
   // 준비 → 실행 → 결과 검증
 });

// 입력 오류: 실제 구현이 이 동작을 보장할 때 사용합니다.
test('제목이 비어 있으면 저장소를 호출하지 않고 검증 오류를 반환한다', () async {
   // ...
 });

// 예외 발생
test('이름이 비어 있으면 GroupFailure 예외가 발생한다', () {
   // expect(() => 호출(), throwsA(isA<GroupFailure>()));
 });

// 오류 상태
test('목록 조회에 실패하면 오류 상태가 된다', () async {
   // ...
 });

// UI 동작
testWidgets('목록을 조회하는 동안 가입 버튼을 비활성화한다', (tester) async {
   // ...
 });
```

위젯 초기 상태와 접근성·공개 계약의 설명 예시:

```dart
testWidgets('목록이 비어 있는 초기 화면에 모임 만들기 버튼을 표시한다', (tester) async {
  // ...
});
testWidgets('닫기 버튼에 닫기 의미의 접근성 레이블을 제공한다', (tester) async {
  // ...
});
testWidgets('비활성 상태에서는 전달받은 onPressed 콜백을 호출하지 않는다', (tester) async {
  // ...
});
```

### 6-2. `group` 설명

- 테스트 대상 클래스·메서드·기능명을 사용합니다.
- 하위 테스트의 공통 맥락을 담고 불필요하게 깊은 중첩을 만들지 않습니다.
- 영문 클래스·메서드명은 그대로 사용해도 됩니다.
- 최종 실행 결과에서 group과 test 설명을 함께 읽어도 뜻이 명확해야 합니다.

```dart
group('CreateGroup', () {
   test('이름이 비어 있으면 저장소를 호출하지 않고 검증 오류를 반환한다', () async {
     // ...
   });
   test('소개가 없으면 소개 없이 모임을 생성한다', () async {
     // ...
   });
 });
```

### 6-3. 경계값·반복 테스트

- 경계값은 구체적인 값과 허용·거부 결과를 설명에 포함합니다.
- 서버 계약이나 팀이 확정한 제한을 기준으로 작성합니다.
- 반복 테스트는 값·권한·화면 크기를 설명에 넣어 실패 사례를 구분합니다.

```dart
// 아래 최대 길이 50자는 예시이며, 실제 확정된 계약에 맞춥니다.
test('제목이 최대 길이 50자이면 저장을 허용한다', () async {
   // ...
 });
test('제목이 최대 길이를 넘는 51자이면 검증 오류를 반환한다', () async {
   // ...
 });

for (final width in [320.0, 393.0]) {
   testWidgets('화면 너비 ${width}px에서 가입 버튼이 잘리지 않는다', (tester) async {
     // ...
   });
 }
```

### 6-4. 적용 범위 및 리뷰 기준

- 합의 이후 새로 작성하거나 수정하는 테스트부터 적용합니다.
- 기존 테스트 전체를 일괄 변경하는 것은 이번 문서 PR의 범위에서 제외합니다.
- 기존 테스트는 해당 기능 수정 시 설명을 함께 정리합니다. 대규모 정리는 별도 작업으로 합의합니다.
- 설명 변경만으로 assertion이나 기능 요구사항을 바꾸지 않습니다.
- 리뷰 시 설명에 적힌 조건·행동·결과가 실제 테스트 코드와 일치하는지 확인합니다.
- 규칙 적용을 위한 lint·정규식 검사는 이번 범위에 포함하지 않습니다.

### 6-5. 팀 합의 요청

- 한국어 설명과 위 문장 형식을 기본으로 사용할지 확인합니다.
- `group`의 클래스·메서드명 사용과 반복 테스트의 사례 표기를 확인합니다.
- 신규·수정 테스트부터 적용하고 기존 전체 변경은 별도 합의하는 범위를 확인합니다.
