## 프로젝트 아키텍처

MOAMOA 프로젝트는 **MVVM 패턴**을 기반으로 하여, 프로젝트 규모의 확장을 고려하여 **Feature First + Layered Architecture** 구조를 사용합니다.

각 Feature 내부는 다음 3개의 Layer로 구분합니다.

```text
presentation
domain
data
```

### 1. Layers

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