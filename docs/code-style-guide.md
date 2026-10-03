# 코드 스타일 가이드라인

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

## 2. 폴더/파일 구성 규칙

```
lib/
  core/
    network/     # Dio 설정, interceptor
    router/      # go_router 설정
    storage/     # secure_storage, shared_preferences 래퍼
  features/
    schedule/
      presentation/
        pages/
        widgets/
        providers/
      domain/
        entities/
        repositories/
        usecases/
      data/
        datasources/
        repositories/
        models/
```

- 폴더 하나(`features/<이름>`)는 도메인 하나를 뜻합니다 (예: `schedule`, `notice`, `attendance`).
- 의존 방향은 `presentation → domain ← data`로 고정합니다. domain은 data와 presentation을 모릅니다.
- **위젯 분리 기준**: `build()` 내부가 2 depth 이상 중첩되거나 50줄을 넘으면 별도 위젯 클래스로 분리합니다. 그 화면에서만 쓰는 위젯은 private(`_`) 클래스로 같은 파일에, 다른 화면에서도 재사용하는 위젯은 `widgets/` 폴더에 public 클래스로 둡니다.

## 3. import 순서

1. `dart:` core 라이브러리
2. `package:flutter` SDK
3. 외부 패키지 (`package:dio`, `package:flutter_riverpod` 등, 알파벳순)
4. 프로젝트 내부 import

각 그룹 사이는 빈 줄 한 줄로 구분합니다.

```dart
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
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