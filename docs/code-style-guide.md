# Flutter Code Style Guide

> Flutter 프로젝트의 일관된 코드 작성과 유지보수를 위한 스타일 가이드입니다.
> 본 문서는 **MVVM + Feature-based Architecture + Riverpod**을 기본 아키텍처로 사용합니다.

---

## 1. Architecture

프로젝트는 **Feature-based Architecture**를 기본으로 구성하고, 각 Feature 내부에서는 **MVVM(Model–View–ViewModel)** 구조를 사용합니다.

### 기본 원칙

* 기능(Feature)을 기준으로 코드를 분리한다.
* UI와 비즈니스 로직을 분리한다.
* 상태 관리는 Riverpod을 사용한다.
* View는 UI 표현에 집중한다.
* ViewModel은 상태와 사용자 행동을 관리한다.
* Model은 데이터 구조와 데이터 변환을 담당한다.
* 여러 Feature에서 공통으로 사용하는 코드는 `core` 또는 `shared`에 둔다.
* Feature 간 직접적인 의존은 최소화한다.

### 전체 구조

```text
lib/
├── app/
│   ├── app.dart
│   ├── router/
│   └── theme/
│
├── core/
│   ├── constants/
│   ├── exceptions/
│   ├── extensions/
│   ├── network/
│   ├── storage/
│   └── utils/
│
├── shared/
│   ├── widgets/
│   ├── models/
│   └── providers/
│
└── features/
    ├── auth/
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   └── repositories/
    │   │
    │   ├── domain/
    │   │   ├── entities/
    │   │   └── repositories/
    │   │
    │   └── presentation/
    │       ├── views/
    │       ├── view_models/
    │       └── widgets/
    │
    ├── home/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    └── profile/
        ├── data/
        ├── domain/
        └── presentation/
```

---

# 2. Feature-based Architecture

기능별로 최상위 디렉터리를 분리합니다.

```text
features/
├── auth/
├── home/
├── profile/
└── settings/
```

예를 들어 로그인 기능과 관련된 코드는 모두 `auth` 내부에 위치합니다.

```text
features/auth/
├── data/
├── domain/
└── presentation/
```

### Feature를 분리하는 기준

다음과 같이 **사용자가 인식할 수 있는 기능 단위**를 기준으로 분리합니다.

```text
auth
home
profile
notification
payment
settings
```

반면 다음과 같이 기술적인 기준으로 Feature를 나누지 않습니다.

```text
view_models/
services/
screens/
models/
```

---

# 3. MVVM

각 Feature의 Presentation Layer는 MVVM 구조를 따릅니다.

```text
presentation/
├── views/
├── view_models/
└── widgets/
```

### 역할

| Layer      | 역할                             |
| ---------- | ------------------------------ |
| View       | UI 표현 및 사용자 입력 전달              |
| ViewModel  | UI 상태 관리 및 비즈니스 흐름 제어          |
| Model      | 데이터 표현 및 변환                    |
| Repository | 데이터 접근 추상화                     |
| DataSource | 실제 API / DB / Local Storage 접근 |

---

# 4. View

View는 **UI를 그리는 역할**에 집중합니다.

### View에서 하지 않는 것

```dart
// ❌ View에서 API 호출
final response = await api.getUser();

// ❌ 복잡한 비즈니스 로직
if (user.age >= 19 && user.isVerified && !user.isBlocked) {
  ...
}

// ❌ 직접 Repository 호출
final user = await userRepository.getUser();
```

View에서는 ViewModel을 통해 상태와 행동을 사용합니다.

```dart
class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginViewModelProvider);

    return Scaffold(
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              ref.read(loginViewModelProvider.notifier).updateEmail(value);
            },
          ),
          ElevatedButton(
            onPressed: state.isLoading
                ? null
                : () {
                    ref
                        .read(loginViewModelProvider.notifier)
                        .login();
                  },
            child: const Text('로그인'),
          ),
        ],
      ),
    );
  }
}
```

---

# 5. ViewModel

ViewModel은 **화면의 상태와 사용자 행동을 관리**합니다.

Riverpod의 `Notifier`, `AsyncNotifier` 등을 ViewModel로 사용합니다.

```dart
@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() {
    return const LoginState();
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  Future<void> login() async {
    // 로그인 로직
  }
}
```

### ViewModel의 책임

* 화면 상태 관리
* 사용자 액션 처리
* Repository 호출
* 입력값 검증
* 로딩 상태 관리
* 에러 상태 관리
* 여러 Repository/API 호출 조합

### ViewModel에서 하지 않는 것

```dart
// ❌ Widget 생성
Widget buildButton() { ... }

// ❌ BuildContext 의존
Navigator.of(context).push(...);

// ❌ UI 레이아웃 관리
Container(
  padding: ...
)
```

ViewModel은 가능한 한 Flutter UI 계층에 독립적으로 유지합니다.

---

# 6. Riverpod

상태 관리는 **Riverpod을 단일 상태 관리 도구로 사용**합니다.

## 기본 원칙

```text
View
 ↓
ViewModel (Riverpod)
 ↓
Repository
 ↓
DataSource
```

View에서 Repository를 직접 호출하지 않습니다.

```dart
// ❌
ref.read(userRepositoryProvider).getUser();
```

다음과 같이 ViewModel을 통해 접근합니다.

```dart
// ✅
ref.read(userViewModelProvider.notifier).loadUser();
```

---

# 7. Riverpod Provider 작성 규칙

가능하면 **Riverpod Generator**를 사용합니다.

```dart
@riverpod
class UserViewModel extends _$UserViewModel {
  @override
  UserState build() {
    return const UserState();
  }
}
```

Provider 이름은 다음 규칙을 사용합니다.

```text
{feature}{역할}Provider
```

예:

```dart
authViewModelProvider
userViewModelProvider
homeViewModelProvider
settingsViewModelProvider
```

Generator를 사용하는 경우 실제 생성되는 Provider 이름에 맞춰 사용합니다.

---

# 8. State

화면 상태는 별도의 State 클래스로 관리하는 것을 권장합니다.

```dart
class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
```

상태가 복잡해지는 경우 `freezed` 사용을 권장합니다.

---

# 9. Async State

비동기 상태는 가능한 한 Riverpod의 `AsyncValue`를 활용합니다.

```dart
@riverpod
Future<User> user(UserRef ref) async {
  return ref.read(userRepositoryProvider).getUser();
}
```

View:

```dart
final userAsync = ref.watch(userProvider);

return userAsync.when(
  data: (user) => UserView(user: user),
  loading: () => const CircularProgressIndicator(),
  error: (error, stackTrace) => ErrorView(error: error),
);
```

### AsyncValue 상태

```text
AsyncLoading
AsyncData
AsyncError
```

불필요하게 다음과 같은 상태를 직접 만들지 않습니다.

```dart
bool isLoading;
bool hasError;
bool hasData;
```

단순한 비동기 데이터 조회라면 `AsyncValue`를 우선 사용합니다.

---

# 10. Repository

Repository는 데이터 접근 방법을 추상화합니다.

```dart
abstract interface class UserRepository {
  Future<User> getUser();

  Future<void> updateUser(User user);
}
```

구현체:

```dart
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<User> getUser() {
    return remoteDataSource.getUser();
  }

  @override
  Future<void> updateUser(User user) {
    return remoteDataSource.updateUser(user);
  }
}
```

### Repository의 책임

* 데이터 소스 선택
* API / Local DB 데이터 조합
* 데이터 접근 추상화
* DataSource 결과를 Domain에서 사용할 수 있는 형태로 제공

---

# 11. DataSource

실제 외부 데이터와 통신하는 코드는 DataSource에 위치합니다.

```text
data/
├── datasources/
│   ├── user_remote_data_source.dart
│   └── user_local_data_source.dart
```

예:

```dart
class UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSource(this.dio);

  Future<UserModel> getUser() async {
    final response = await dio.get('/user');

    return UserModel.fromJson(response.data);
  }
}
```

ViewModel에서 직접 Dio를 호출하지 않습니다.

```dart
// ❌
final response = await dio.get('/user');
```

---

# 12. Model

API 응답이나 로컬 데이터와 직접 연결되는 객체는 `Model`로 구분합니다.

```dart
class UserModel {
  final int id;
  final String name;

  const UserModel({
    required this.id,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
```

Domain에서 사용하는 순수한 개념은 `Entity`로 분리합니다.

```dart
class User {
  final int id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });
}
```

---

# 13. Domain

비즈니스 규칙과 핵심 개념을 Domain에 둡니다.

```text
domain/
├── entities/
└── repositories/
```

예:

```dart
class User {
  final int id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });
}
```

Repository interface:

```dart
abstract interface class UserRepository {
  Future<User> getUser();
}
```

### 의존성 방향

```text
Presentation
      ↓
   Domain
      ↑
    Data
```

Data Layer는 Domain의 Repository interface를 구현합니다.

---

# 14. Widget 분리 기준

View가 지나치게 커지면 Widget을 분리합니다.

### 분리하지 않아도 되는 경우

```dart
Column(
  children: [
    const Text('로그인'),
    ...
  ],
)
```

단순한 UI는 그대로 둡니다.

### 분리해야 하는 경우

```dart
LoginHeader()
LoginForm()
LoginButton()
SocialLoginButtons()
```

다음 상황에서는 분리를 고려합니다.

* 코드가 길어지는 경우
* 하나의 UI 영역이 독립적인 역할을 가지는 경우
* 재사용되는 경우
* 테스트가 필요한 경우
* View의 가독성을 떨어뜨리는 경우

---

# 15. Widget 파일명

파일명은 `snake_case`를 사용합니다.

```text
login_view.dart
login_form.dart
login_button.dart
social_login_buttons.dart
```

Class 이름은 `PascalCase`를 사용합니다.

```dart
class LoginView extends ConsumerWidget {}

class LoginForm extends StatelessWidget {}

class LoginButton extends StatelessWidget {}
```

---

# 16. Naming Convention

Dart 공식 스타일을 따릅니다.

### 파일

```text
snake_case.dart
```

### Class

```dart
PascalCase
```

### 변수 / 함수

```dart
camelCase
```

### 상수

Dart에서는 일반적으로 `camelCase`를 사용합니다.

```dart
const defaultPadding = 16.0;
const maxRetryCount = 3;
```

### Boolean

Boolean 변수는 의미가 명확하도록 작성합니다.

```dart
isLoading
isLoggedIn
hasPermission
canSubmit
```

다음과 같이 작성하지 않습니다.

```dart
loading
login
permission
submit
```

---

# 17. Private Member

외부에 노출할 필요가 없는 멤버는 `_`를 사용합니다.

```dart
class UserViewModel {
  final UserRepository _repository;

  UserViewModel(this._repository);

  Future<void> _refreshUser() async {
    ...
  }
}
```

---

# 18. Import 순서

Import는 다음 순서를 권장합니다.

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user.dart';
import '../view_models/user_view_model.dart';
import '../widgets/user_profile.dart';
```

순서:

```text
1. Dart SDK
2. Flutter
3. External Package
4. Project Internal
```

불필요한 import는 제거합니다.

---

# 19. const

컴파일 타임에 생성 가능한 Widget은 `const`를 사용합니다.

```dart
const SizedBox(height: 16);

const Text('Hello');
```

Widget 생성 시 가능한 한 `const`를 우선합니다.

```dart
return const Scaffold(
  body: Center(
    child: Text('Hello'),
  ),
);
```

---

# 20. Build Method

`build()` 내부에는 복잡한 비즈니스 로직을 작성하지 않습니다.

```dart
// ❌
@override
Widget build(BuildContext context) {
  final isValid =
      email.isNotEmpty &&
      password.length >= 8 &&
      password.contains('@');

  ...
}
```

검증 로직은 ViewModel 등 적절한 계층으로 이동합니다.

```dart
// ✅
final canLogin = ref.watch(
  loginViewModelProvider.select((state) => state.canLogin),
);
```

---

# 21. Riverpod Select

화면에서 필요한 상태만 구독하도록 `select`를 적극적으로 활용합니다.

```dart
final isLoading = ref.watch(
  loginViewModelProvider.select(
    (state) => state.isLoading,
  ),
);
```

전체 State가 변경될 때마다 Widget이 rebuild될 필요가 없다면 `select`를 사용합니다.

---

# 22. ref.read / ref.watch

### watch

UI가 상태 변경에 반응해야 할 때 사용합니다.

```dart
final state = ref.watch(userViewModelProvider);
```

### read

특정 시점에 값을 읽거나 Action을 실행할 때 사용합니다.

```dart
ref
    .read(userViewModelProvider.notifier)
    .loadUser();
```

기본 원칙:

```text
UI 상태 구독 → watch
Action 실행 → read
```

---

# 23. Navigation

Navigation 로직은 ViewModel에 넣지 않습니다.

```dart
// ❌ ViewModel
Navigator.push(...);
```

Navigation은 View 또는 Router 계층에서 처리합니다.

```dart
// ✅
context.push('/profile');
```

복잡한 Navigation 구조에서는 `go_router` 등의 Router를 사용하고 Router 설정은 `app/router`에 둡니다.

---

# 24. Error Handling

예외를 무조건 숨기지 않습니다.

```dart
try {
  await repository.login();
} catch (e, stackTrace) {
  state = state.copyWith(
    errorMessage: '로그인에 실패했습니다.',
  );

  rethrow;
}
```

사용자에게 보여줄 메시지와 개발자가 확인할 실제 Exception을 구분합니다.

```text
Exception
   ↓
Repository / ViewModel
   ↓
사용자에게 적절한 Error Message
```

민감한 서버 에러나 StackTrace를 그대로 UI에 노출하지 않습니다.

---

# 25. Logging

`print()`를 무분별하게 사용하지 않습니다.

```dart
// ❌
print(response);

// ❌
print('login error: $e');
```

프로젝트에서 사용하는 Logger를 통해 로그를 남깁니다.

```dart
logger.e(
  'Login failed',
  error: error,
  stackTrace: stackTrace,
);
```

Production 환경에서는 민감한 개인정보와 인증정보를 로그에 남기지 않습니다.

---

# 26. Dependency Injection

Repository, DataSource 등의 의존성은 Riverpod Provider를 통해 관리합니다.

```dart
@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl(
    remoteDataSource: ref.read(userRemoteDataSourceProvider),
  );
}
```

ViewModel:

```dart
@riverpod
class UserViewModel extends _$UserViewModel {
  late final UserRepository _repository;

  @override
  UserState build() {
    _repository = ref.read(userRepositoryProvider);

    return const UserState();
  }
}
```

가능하면 객체를 직접 생성하지 않고 Provider를 통해 주입합니다.

---

# 27. Folder Naming

폴더는 복수형 또는 프로젝트 전체 규칙에 맞춰 일관되게 사용합니다.

권장:

```text
views/
widgets/
view_models/
repositories/
datasources/
models/
entities/
```

ViewModel은 다음과 같이 작성합니다.

```text
view_models/
    login_view_model.dart
    profile_view_model.dart
```

---

# 28. File Naming

파일명은 하나의 주요 책임을 기준으로 작성합니다.

```text
user_view.dart
user_view_model.dart
user_repository.dart
user_repository_impl.dart
user_model.dart
user_entity.dart
```

다음처럼 여러 책임을 하나의 파일에 넣지 않습니다.

```text
user.dart
```

파일 하나에 모든 User 관련 코드를 넣는 방식은 Feature 규모가 커질수록 피합니다.

---

# 29. Barrel File

`export`를 통한 Barrel File은 필요한 경우에만 사용합니다.

```dart
export 'login_view.dart';
export 'login_form.dart';
export 'login_button.dart';
```

무분별한 `export`는 의존성 구조를 숨기고 코드 탐색을 어렵게 만들 수 있으므로 Feature 내부에서 필요한 범위로 제한합니다.

---

# 30. Dependency Rule

Feature 간 직접적인 내부 구현체 접근을 피합니다.

```text
features/auth
      ↓
features/home
```

다음과 같은 직접 접근은 지양합니다.

```dart
import '../../auth/data/repositories/auth_repository_impl.dart';
```

대신 공통 기능은 적절한 추상화 또는 `core/shared`를 통해 접근합니다.

```text
Feature
  ↓
Shared / Core
```

---

# 31. Core vs Shared

### core

프로젝트 전체에서 기술적으로 공통으로 사용하는 코드입니다.

```text
core/
├── network/
├── storage/
├── exceptions/
├── extensions/
└── utils/
```

예:

```text
Dio 설정
Secure Storage
Logger
Exception
DateTime Extension
```

### shared

여러 Feature에서 사용하는 UI 또는 공통 도메인 요소입니다.

```text
shared/
├── widgets/
├── models/
└── providers/
```

예:

```text
AppButton
AppTextField
LoadingView
EmptyView
```

---

# 32. Feature 내부 의존성

Feature 내부에서는 다음 방향을 기본으로 합니다.

```text
presentation
     ↓
   domain
     ↑
    data
```

Presentation에서 Data의 구체적인 구현체를 직접 참조하지 않습니다.

```dart
// ❌
import '../data/repositories/user_repository_impl.dart';
```

Repository abstraction을 통해 접근합니다.

```dart
// ✅
ref.read(userRepositoryProvider);
```

---

# 33. Recommended Example

최종적인 Feature 구조 예시:

```text
features/
└── profile/
    ├── data/
    │   ├── datasources/
    │   │   ├── profile_local_data_source.dart
    │   │   └── profile_remote_data_source.dart
    │   │
    │   ├── models/
    │   │   └── profile_model.dart
    │   │
    │   └── repositories/
    │       └── profile_repository_impl.dart
    │
    ├── domain/
    │   ├── entities/
    │   │   └── profile.dart
    │   │
    │   └── repositories/
    │       └── profile_repository.dart
    │
    └── presentation/
        ├── views/
        │   └── profile_view.dart
        │
        ├── view_models/
        │   └── profile_view_model.dart
        │
        └── widgets/
            ├── profile_header.dart
            └── profile_info.dart
```

---

# 34. 전체 데이터 흐름

```text
┌──────────────┐
│     View     │
└──────┬───────┘
       │
       │ user action
       ▼
┌──────────────┐
│  ViewModel   │
│   Riverpod   │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Repository   │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  DataSource  │
└──────┬───────┘
       │
       ▼
   API / DB
```

데이터가 다시 UI로 전달되는 경우:

```text
API / DB
   ↓
DataSource
   ↓
Repository
   ↓
ViewModel
   ↓
Riverpod State
   ↓
View
```

---

# 35. Code Style

Dart 공식 Formatter를 사용합니다.

```bash
dart format .
```

Lint를 사용합니다.

```bash
flutter analyze
```

가능하면 CI에서 다음 검사를 수행합니다.

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

---

# 36. 주석 작성 원칙

코드만 봐도 이해할 수 있는 내용은 주석을 작성하지 않습니다.

```dart
// ❌ 숫자를 1 증가시킨다.
count++;
```

**왜 그렇게 구현했는지** 설명이 필요한 경우 주석을 작성합니다.

```dart
// 서버의 rate limit 때문에 연속 요청을 방지하기 위해 debounce를 적용한다.
```

주석은 코드의 동작보다는 **의도와 이유**를 설명합니다.

---

# 37. TODO

TODO에는 가능한 경우 해결해야 할 이유와 범위를 작성합니다.

```dart
// TODO: 결제 API 연동 후 임시 Mock 제거
```

단순히 다음처럼 작성하지 않습니다.

```dart
// TODO: 나중에 수정
```

---

# 38. 테스트

Feature 단위로 테스트를 작성합니다.

```text
features/
└── auth/
    ├── data/
    ├── domain/
    └── presentation/

test/
└── features/
    └── auth/
        ├── data/
        ├── domain/
        └── presentation/
```

최소한 ViewModel과 핵심 비즈니스 로직은 테스트하는 것을 권장합니다.

```text
Repository Test
ViewModel Test
Widget Test
Integration Test
```

---

# 39. PR / Commit

Commit은 변경 목적이 명확하도록 작성합니다.

```text
feat: 로그인 기능 추가
fix: 로그인 실패 시 에러 처리 수정
refactor: 사용자 상태 관리 구조 개선
test: 로그인 ViewModel 테스트 추가
docs: Flutter 코드 스타일 가이드 추가
chore: Riverpod 의존성 업데이트
```

하나의 Commit에 서로 관계없는 변경사항을 섞지 않습니다.

```text
❌ 로그인 기능 추가 + README 수정 + 홈 화면 디자인 변경
```

가능하면:

```text
✅ feat: 로그인 기능 추가
✅ docs: README 업데이트
✅ feat: 홈 화면 UI 개선
```

---

# 40. 핵심 규칙 요약

프로젝트의 모든 코드는 다음 원칙을 우선적으로 따릅니다.

```text
1. Feature 기준으로 코드를 분리한다.

2. Feature 내부는
   Data / Domain / Presentation으로 분리한다.

3. Presentation은
   View / ViewModel / Widget으로 구성한다.

4. 상태 관리는 Riverpod을 사용한다.

5. View는 UI 표현에 집중한다.

6. ViewModel은 화면 상태와 사용자 행동을 관리한다.

7. Repository는 데이터 접근을 추상화한다.

8. DataSource는 API / DB 등의 실제 데이터 접근을 담당한다.

9. View에서 Repository / DataSource를 직접 호출하지 않는다.

10. ViewModel에서 UI 코드를 작성하지 않는다.

11. Feature 간 내부 구현체를 직접 참조하지 않는다.

12. 공통 코드는 core / shared로 분리한다.

13. 가능한 경우 const를 사용한다.

14. dart format / flutter analyze를 통과하는 코드를 작성한다.

15. 코드의 동작보다 의도와 책임을 명확하게 만드는 것을 우선한다.
```

---

# 41. Recommended Stack

본 아키텍처에서 권장하는 기본 기술 스택입니다.

```text
Flutter
├── State Management
│   └── Riverpod
│
├── Routing
│   └── go_router
│
├── Network
│   └── Dio
│
├── Serialization
│   └── json_serializable / freezed
│
├── Code Generation
│   └── build_runner
│
├── Local Storage
│   └── 프로젝트 요구사항에 따라 선택
│
└── Testing
    ├── flutter_test
    └── mocktail
```

단, 프로젝트에서 실제로 사용하는 패키지만 도입하며 **패키지 추가를 목적으로 기술을 선택하지 않습니다.**

---

# 42. Architecture Decision Rule

새로운 코드를 추가할 때 다음 질문을 먼저 확인합니다.

```text
Q1. 특정 Feature에만 필요한가?
 └─ YES → 해당 Feature 내부에 작성

Q2. 여러 Feature에서 사용하는가?
 └─ YES → shared 검토

Q3. UI와 관련 없는 기술적인 공통 기능인가?
 └─ YES → core 검토

Q4. 화면 상태를 관리하는 코드인가?
 └─ YES → ViewModel

Q5. API / DB 접근 코드인가?
 └─ YES → DataSource

Q6. 데이터 접근 방법을 추상화하는 코드인가?
 └─ YES → Repository

Q7. 핵심 비즈니스 개념인가?
 └─ YES → Domain Entity
```

**새로운 폴더를 만들기 전에 기존 구조로 해결할 수 있는지 먼저 확인합니다.**

---

## Final Principle

> **Feature로 분리하고, MVVM으로 책임을 분리하며, Riverpod으로 상태를 관리한다.**

코드의 목표는 단순히 동작하는 것이 아니라,

```text
읽기 쉽고
↓
변경하기 쉽고
↓
테스트하기 쉽고
↓
Feature가 커져도 구조가 무너지지 않는 것
```

입니다.
