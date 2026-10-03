## 프로젝트 아키텍처

MOAMOA 프로젝트는 **MVVM 패턴**을 기반으로 하여, 프로젝트 규모의 확장을 고려하여 **Feature First + Layered Architecture** 구조를 사용합니다.

각 Feature 내부는 다음 3개의 Layer로 구분합니다.

```text
presentation
domain
data
```

### 1. Presentation Layer

UI 및 화면 상태를 담당합니다.

주요 구성 요소:

- Page / Screen
- Widget
- ViewModel
- Riverpod Provider
- UI State

```text
presentation/
├── pages/
├── widgets/
├── providers/
└── viewmodels/
```

#### Domain Layer

비즈니스 규칙과 핵심 인터페이스를 담당합니다.

주요 구성 요소:

- Entity
- Repository Interface
- UseCase

```text
domain/
├── entities/
├── repositories/
└── usecases/
```

#### Data Layer

API, Local Storage 등 외부 데이터 접근을 담당합니다.

주요 구성 요소:

- DTO / Model
- DataSource
- Repository Implementation

```text
data/
├── datasources/
├── models/
└── repositories/
```

### 2. Folder Structure

기본 `lib/` 구조는 다음과 같이 구성합니다.

```text
lib/
├── main.dart
│
├── app/
│   ├── app.dart
│   └── router/
│       └── app_router.dart
│
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   │   ├── dio_provider.dart
│   │   └── api_client.dart
│   ├── storage/
│   │   ├── secure_storage.dart
│   │   └── shared_preferences.dart
│   ├── utils/
│   └── widgets/
│
└── features/
    ├── auth/
    │   ├── presentation/
    │   │   ├── pages/
    │   │   ├── widgets/
    │   │   ├── providers/
    │   │   └── viewmodels/
    │   │
    │   ├── domain/
    │   │   ├── entities/
    │   │   ├── repositories/
    │   │   └── usecases/
    │   │
    │   └── data/
    │       ├── datasources/
    │       ├── models/
    │       └── repositories/
    │
    ├── group/
    ├── schedule/
    ├── notice/
    └── settlement/
```

#### 2-1. Feature First 원칙

기능 단위로 코드를 분리합니다.

예:

```text
features/
├── auth/
├── group/
├── schedule/
├── notice/
└── settlement/
```

새로운 기능을 추가할 때는 가능한 한 해당 Feature 내부에서 구현을 완료합니다.

여러 Feature에서 공통으로 사용하는 코드는 `core/`에 배치합니다.

### 3. State Management

상태 관리는 **Riverpod**을 사용합니다.

Provider 선언은 별도의 Provider 클래스를 과도하게 분리하지 않고 **Inline 방식**을 기본으로 사용합니다.

#### Repository Provider

```dart
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(
    dio: ref.watch(dioProvider),
  );
});
```

#### AsyncNotifierProvider

```dart
final userProvider =
    AsyncNotifierProvider<UserNotifier, User?>(
  UserNotifier.new,
);
```

#### Riverpod Generator

필요한 경우 `@riverpod` 방식도 사용할 수 있습니다.

```dart
@riverpod
Future<User> user(Ref ref) async {
  // TODO: implement
}
```

---

### 4. Stream

실시간 데이터 처리가 필요한 기능에서는 Dart `Stream`을 사용합니다.

Riverpod과 함께 사용할 경우 `StreamProvider` 사용을 기본으로 합니다.

예:

```dart
final attendanceStreamProvider =
    StreamProvider<List<Attendance>>((ref) {
  return ref
      .watch(attendanceRepositoryProvider)
      .watchAttendance();
});
```

사용 예:

```dart
final attendanceAsync =
    ref.watch(attendanceStreamProvider);
```

---

### 5. Network

네트워크 통신은 **Dio**를 사용합니다.

Dio 인스턴스는 Provider를 통해 주입합니다.

```dart
final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
});
```

Repository에서는 직접 Dio 객체를 생성하지 않고 Provider를 통해 전달받습니다.

```dart
final userRepositoryProvider =
    Provider<UserRepository>((ref) {
  return UserRepository(
    dio: ref.watch(dioProvider),
  );
});
```

---

### 6. Local Storage

로컬 데이터 저장은 데이터 성격에 따라 구분하여 사용합니다.

#### flutter_secure_storage

보안이 필요한 데이터 저장에 사용합니다.

예:

- Access Token
- Refresh Token
- 인증 관련 데이터

#### shared_preferences

일반적인 앱 설정 및 단순 상태 저장에 사용합니다.

예:

- 최초 실행 여부
- 사용자 설정
- Onboarding 완료 여부
- UI 설정 값

민감한 정보를 `shared_preferences`에 저장하지 않습니다.

---

### 7. Routing

라우팅은 **go_router**를 사용합니다.

라우터 설정은 `app/router/`에서 관리합니다.

```text
lib/
└── app/
    └── router/
        └── app_router.dart
```

예:

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
    ),
  ],
);
```

화면 이동 시 문자열 Route를 여러 위치에서 직접 관리하지 않고 공통 Router 설정을 사용합니다.

---

### 8. Dependency Injection

별도의 DI 라이브러리는 사용하지 않고 **Riverpod Provider**를 Dependency Injection 도구로 사용합니다.

의존성 흐름 예:

```text
UI
 ↓
ViewModel / Provider
 ↓
UseCase
 ↓
Repository Interface
 ↓
Repository Implementation
 ↓
DataSource / Dio / Local Storage
```