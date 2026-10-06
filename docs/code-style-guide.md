# 코드 스타일 가이드라인

현재 확정된 기술 스택(Flutter, MVVM Feature-First + Layered Architecture, Dio, Riverpod[Inline], Stream + StreamProvider, flutter_secure_storage/shared_preferences, go_router, flutter_lints)을 기준으로 작성한 코드 컨벤션입니다. 기본 스타일은 [Effective Dart: Style](https://dart.dev/effective-dart/style)을 따르고, 프로젝트에 특화된 부분만 아래에 추가로 정의합니다.

## 1. 네이밍 규칙

**파일명**: snake_case + 역할 접미사

| 역할 | 파일명 예시 |
| --- | --- |
| 화면(페이지) | `schedule_list_page.dart` |
| 하위 위젯 | `schedule_card.dart` |
| Notifier (ViewModel) | `schedule_list_notifier.dart` |
| Provider 모음 | `schedule_providers.dart` |
| Repository 인터페이스 | `schedule_repository.dart` |
| Repository 구현체 | `schedule_repository_impl.dart` |
| UseCase | `get_schedules.dart` |
| Entity (domain) | `schedule.dart` |
| DTO (data) | `schedule_dto.dart` |

**클래스명**: PascalCase

- Notifier: `ScheduleListNotifier`
- Repository: `ScheduleRepository`(인터페이스) / `ScheduleRepositoryImpl`(구현체)
- UseCase: `GetSchedules`
- Entity / DTO: `Schedule` / `ScheduleDto`
- Widget: `ScheduleListPage`, `ScheduleCard` — 다른 파일에서 재사용하지 않는 내부 전용 위젯은 `_ScheduleCard`처럼 언더스코어(private)로 작성

**변수/함수명**: camelCase

**Provider 변수명**: 역할과 상관없이 반드시 `xxxProvider`로 끝냅니다.

```dart
final dioProvider = Provider<Dio>((ref) => buildDio());
final scheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => ScheduleRepositoryImpl(ref.watch(scheduleRemoteDataSourceProvider)),
);
final scheduleListProvider =
    AsyncNotifierProvider<ScheduleListNotifier, List<Schedule>>(ScheduleListNotifier.new);
```

## 2. 파일 구성 규칙

> 전체 폴더 구조(Feature-First + Layered Architecture)는 [프로젝트 아키텍처](../README.md#프로젝트-아키텍처) 섹션을 따릅니다. 여기서는 그 구조 안에서 파일을 나누는 기준만 정의합니다.

- **위젯 분리 기준**: `build()` 내부가 3~4 depth 이상 중첩되거나 50줄을 넘으면 별도 위젯 클래스로 분리합니다. 그 화면에서만 쓰는 위젯은 private(`_`) 클래스로 같은 파일에, 다른 화면에서도 재사용하는 위젯은 `widgets/` 폴더에 public 클래스로 둡니다.
- 파일 하나에는 public 클래스 1개만 둡니다 (private 헬퍼 위젯/클래스는 예외).

예를 들어 `build()` 안에서 카드 UI를 직접 구성하면:

```dart
// Before: build() 안에서 카드 UI를 직접 구성
class ScheduleListPage extends StatelessWidget {
  const ScheduleListPage({super.key, required this.schedules});

  final List<Schedule> schedules;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: schedules.map((schedule) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(schedule.title),
                Text(schedule.date),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
```

그 화면에서만 쓰는 위젯이면 private 클래스로 같은 파일에 분리합니다:

```dart
// After: 같은 화면에서만 쓰는 위젯은 private 클래스로 분리
class ScheduleListPage extends StatelessWidget {
  const ScheduleListPage({super.key, required this.schedules});

  final List<Schedule> schedules;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: schedules.map((s) => _ScheduleCard(schedule: s)).toList(),
    );
  }
}

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
            Text(schedule.date),
          ],
        ),
      ),
    );
  }
}
```

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