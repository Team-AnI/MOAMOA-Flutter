# MOAMOA

Team AnI의 MOAMOA Flutter 앱 저장소입니다.

## 목차

- [우리 팀 기여 가이드](#우리-팀-기여-가이드)
- [GitHub 컨벤션](#github-컨벤션)
- [프로젝트 아키텍처](#프로젝트-아키텍처)
- [코드 컨벤션 가이드라인](#코드-컨벤션-가이드라인)
- [기타](#기타)

---

## 우리 팀 기여 가이드

### 1. 개발 환경 준비

#### 1-1. 요구 버전

팀원 모두 아래 버전에 맞춰 개발합니다. 버전이 다르면 `pubspec.lock`, 빌드 결과가 달라질 수 있습니다.

| 항목 | 버전 |
| --- | --- |
| Flutter | **3.44.9** (stable, revision `6b182d2c75`) |
| Dart | **3.12.2** (`sdk: ^3.12.2`) |
| Java (JDK) | **17** |
| Gradle | 9.1.0 (Gradle Wrapper 사용) |
| Android | `compileSdk` / `minSdk` / `targetSdk` 는 Flutter 기본값 사용 |
| iOS | 최소 배포 버전 **13.0** |
| Xcode | 최신 stable 버전 (macOS 전용) |

#### 1-2. 세팅 스크립트 (빠른 시작)

프로젝트 루트의 `moamoa-flutter-setup.sh` 로 환경 점검과 의존성 설치를 한 번에 할 수 있습니다.
Flutter SDK, Android Studio, Xcode 같은 도구 자체를 설치하지는 않으므로, 경고가 나오면 아래 1-3 ~ 1-5 를 참고해 해결해주세요.

```bash
./moamoa-flutter-setup.sh            # 환경 점검 + upstream 등록 + pub get + pod install
./moamoa-flutter-setup.sh --check    # 환경 점검만 (아무것도 변경하지 않음)
```

| 단계 | 내용 |
| --- | --- |
| 버전 점검 | Flutter, Dart, JDK, Xcode/CocoaPods(macOS) 가 요구 버전과 맞는지 확인 |
| Git remote | `upstream` remote 가 없으면 Team-AnI 저장소로 등록 |
| 의존성 설치 | `flutter pub get`, (macOS) `pod install` |
| 최종 점검 | `flutter doctor` 결과 출력 |

> 요구 버전이 바뀌면 이 README 의 표와 스크립트 상단의 `REQUIRED_*` 변수를 함께 수정해주세요.

#### 1-3. Flutter SDK 설치

1. [Flutter 공식 설치 가이드](https://docs.flutter.dev/get-started/install)를 따라 SDK 를 설치합니다.
2. 버전을 맞춥니다.
   ```bash
   flutter --version          # 현재 버전 확인
   flutter upgrade            # 또는 특정 버전으로 맞추기
   flutter downgrade <version>
   ```
3. 환경을 점검하고, `[✗]` 항목이 없도록 해결합니다.
   ```bash
   flutter doctor -v
   ```

#### 1-4. 플랫폼별 설정

**Android**

- [Android Studio](https://developer.android.com/studio) 를 설치합니다.
- SDK Manager 에서 Android SDK, Command-line Tools, Build-Tools 를 설치합니다.
- 라이선스에 동의합니다.
  ```bash
  flutter doctor --android-licenses
  ```
- JDK 17 을 사용하도록 설정합니다. (Android Studio 내장 JDK 를 쓰지 않는 경우)
  ```bash
  flutter config --jdk-dir <JDK_17_경로>
  ```

**iOS (macOS 전용)**

- App Store 에서 Xcode 를 설치한 뒤 초기 설정을 완료합니다.
  ```bash
  sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
  sudo xcodebuild -runFirstLaunch
  ```
- CocoaPods 를 설치합니다.
  ```bash
  brew install cocoapods
  ```

#### 1-5. IDE 설정

- **Android Studio / IntelliJ**: Flutter, Dart 플러그인 설치
- **VS Code**: [Flutter 확장](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) 설치
- 저장 시 자동 포맷(`dart format`)을 켜두는 것을 권장합니다.

#### 1-6. 프로젝트 clone 및 실행

```bash
# 원본 저장소를 개인 계정으로 Fork 한 뒤 clone
git clone https://github.com/<your-id>/MOAMOA-Flutter.git
cd MOAMOA-Flutter

# 원본 저장소를 upstream 으로 등록
git remote add upstream https://github.com/Team-AnI/MOAMOA-Flutter.git

# 의존성 설치
flutter pub get

# iOS 를 실행하는 경우 (macOS)
cd ios && pod install && cd ..

# 연결된 기기 확인 후 실행
flutter devices
flutter run
```

#### 1-7. 자주 쓰는 명령어

| 명령어 | 설명 |
| --- | --- |
| `flutter pub get` | 의존성 설치 |
| `flutter clean` | 빌드 캐시 삭제 (빌드가 꼬였을 때) |
| `dart format .` | 코드 포맷팅 |
| `flutter analyze` | 정적 분석 (`analysis_options.yaml` 기준) |
| `flutter test` | 테스트 실행 |
| `flutter build apk` | Android 빌드 |
| `flutter build ios` | iOS 빌드 (macOS) |

> ⚠️ `android/local.properties` 등 로컬 환경 파일은 커밋하지 않습니다.

### 2. 작업 흐름

1. 작업 전 **Issue** 를 생성하고 담당자를 지정합니다. ([이슈 등록 방법](#1-이슈issue-등록))
2. 최신 `main` 을 동기화합니다.
   ```bash
   git checkout main
   git pull upstream main
   ```
3. Issue 번호를 포함한 브랜치를 생성합니다.
4. 작업 후 커밋하고, 본인 Fork 로 push 합니다.
5. `upstream/main` 을 대상으로 **Pull Request** 를 생성합니다.
6. 메인테이너가 리뷰어로 자동 지정되며, **1명 이상 Approve** 후 머지합니다.

### 3. 브랜치 규칙

| 브랜치 | 용도 | 예시 |
| --- | --- | --- |
| `main` | 배포 가능한 안정 브랜치 (직접 push 금지) | - |
| `feature/#이슈번호-기능이름` | 새로운 기능 | `feature/#12-login-ui` |
| `fix/#이슈번호-설명` | 버그 수정 | `fix/#15-crash-on-start` |
| `refactor/#이슈번호-수정범위` | 리팩터링 | `refactor/#20-auth-repo` |
| `chore/#이슈번호-설명` | 빌드, 설정, 의존성 등 | `chore/#3-update-pubspec` |
| `docs/#이슈번호-설명` | 문서 | `docs/#1-readme` |

### 4. 이슈 / 커밋 / PR 작성

이슈, 커밋 메시지, PR 메시지는 [GitHub 컨벤션](#github-컨벤션) 섹션을 따릅니다.

### 5. 코드 리뷰

- 리뷰 요청을 받으면 가능한 **24시간 이내**에 응답합니다.
- 코멘트는 근거와 함께 정중하게 남기고, 필수 수정과 제안을 구분합니다.
  - 예: `[필수]`, `[제안]`, `[질문]`
- 모든 코멘트가 해결(Resolve)된 후 머지합니다.

---

## GitHub 컨벤션

### 1. 이슈(Issue) 등록

> 모든 작업은 **이슈 카드 등록부터** 시작합니다.
> 기능 개발, 버그 수정뿐 아니라 "코드 스타일 가이드라인 정하기" 같은 문서/논의 작업도 이슈로 먼저 등록합니다.
> 이슈 번호는 브랜치, 커밋, PR 에 모두 사용됩니다.

#### 1-1. 등록 방법

1. 저장소의 [Issues 탭](https://github.com/Team-AnI/MOAMOA-Flutter/issues) → **New issue** 를 클릭하고, 작업 종류에 맞는 템플릿을 선택합니다.
   - ✨ 기능 (FEAT) / 🐞 버그 (FIX) / 📚 문서 (DOCS) / 🛠 기타 작업 (REFACTOR, DESIGN, CHORE, TEST, CI)
2. 템플릿에 채워진 형식에 맞춰 **제목**과 **본문**을 작성합니다.
3. 오른쪽 사이드바에서 다음 항목을 설정합니다.
   - **Assignees**: 작업할 담당자 (본인)
   - **Labels**: 작업 종류 (아래 1-4 참고)
   - **Projects**: 팀 프로젝트 보드에 카드로 추가 (사용하는 경우)
   - **Milestone**: 해당되는 스프린트/버전 (사용하는 경우)
4. **Submit new issue** 로 등록하고, 생성된 이슈 번호(`#번호`)를 확인합니다.
5. 이슈 번호로 브랜치를 만들고 작업을 시작합니다. (예: `docs/#7-code-style-guide`)

CLI 로 등록할 수도 있습니다. ([GitHub CLI](https://cli.github.com/) 필요)

```bash
gh issue create \
  --repo Team-AnI/MOAMOA-Flutter \
  --title "[DOCS] 코드 스타일 가이드라인 정의" \
  --label documentation \
  --assignee @me
```

#### 1-2. 제목

```
[TYPE] 작업 내용 요약
```

| TYPE | 용도 | 예시 |
| --- | --- | --- |
| `[FEAT]` | 새로운 기능 | `[FEAT] 소셜 로그인 기능 구현` |
| `[FIX]` | 버그 수정 | `[FIX] 앱 시작 시 크래시 발생` |
| `[REFACTOR]` | 리팩터링 | `[REFACTOR] AuthRepository 구조 개선` |
| `[DESIGN]` | UI/디자인 작업 | `[DESIGN] 홈 화면 레이아웃 수정` |
| `[DOCS]` | 문서, 가이드라인 | `[DOCS] 코드 스타일 가이드라인 정의` |
| `[CHORE]` | 빌드, 설정, 의존성 | `[CHORE] Flutter 버전 업데이트` |
| `[TEST]` | 테스트 | `[TEST] 로그인 ViewModel 테스트 작성` |
| `[CI]` | CI/CD 설정 | `[CI] PR CI 구성` |

#### 1-3. 본문 템플릿

> 이슈 템플릿은 `.github/ISSUE_TEMPLATE/` 에 있으며, New issue 에서 선택하면 자동으로 채워집니다.

```markdown
## 📝 설명
- 어떤 작업인지, 왜 필요한지 적습니다.

## ✅ 할 일
- [ ] 세부 작업 1
- [ ] 세부 작업 2

## 🙋 참고 사항
- 관련 문서, 스크린샷, 논의가 필요한 부분 등을 적습니다.
```

버그 이슈는 아래 항목을 추가로 적습니다.

```markdown
## 🐞 재현 방법
1. ...
2. ...

## 기대 동작 / 실제 동작
- 기대: ...
- 실제: ...

## 환경
- 기기 / OS: (예: iPhone 15, iOS 18)
- 앱 버전 / 브랜치:
```

#### 1-4. 라벨

| 라벨 | 용도 |
| --- | --- |
| `enhancement` | 새로운 기능, 개선 (`[FEAT]`, `[REFACTOR]`, `[DESIGN]`) |
| `bug` | 버그 (`[FIX]`) |
| `documentation` | 문서, 가이드라인 (`[DOCS]`) |
| `question` | 논의/질문이 필요한 이슈 |
| `help wanted` | 도움이 필요한 이슈 |
| `good first issue` | 처음 합류한 팀원이 하기 좋은 이슈 |

#### 1-5. 예시: 코드 스타일 가이드라인 이슈

```markdown
제목: [DOCS] 코드 스타일 가이드라인 정의
라벨: documentation
담당자: @담당자

## 📝 설명
- 팀원 간 코드 스타일을 통일하기 위해 코드 컨벤션을 정하고 README 에 정리합니다.

## ✅ 할 일
- [ ] 네이밍 규칙 (클래스, 변수, 파일명)
- [ ] 폴더/파일 구성 규칙
- [ ] analysis_options.yaml lint 규칙 결정
- [ ] README "코드 컨벤션 가이드라인" 섹션 작성

## 🙋 참고 사항
- [Effective Dart: Style](https://dart.dev/effective-dart/style)
```

#### 1-6. 이슈 종료

- PR 본문에 `close #이슈번호` 를 적으면 PR 이 머지될 때 이슈가 자동으로 닫힙니다.
- 작업하지 않기로 한 이슈는 사유를 코멘트로 남기고 **Close as not planned** 로 닫습니다.

### 2. 커밋 메시지 컨벤션

#### 2-1. 형식

```
<type>: <subject> (#이슈번호)

<body>

<footer>
```

- **header** (`<type>: <subject> (#이슈번호)`): 필수
- **body**: 선택. 변경한 내용이 header 만으로 설명되지 않을 때 작성
- **footer**: 선택. 관련 이슈 처리, Breaking Change 등을 작성

#### 2-2. type

| type | 설명 | 예시 |
| --- | --- | --- |
| `feat` | 새로운 기능 추가 | `feat: 로그인 화면 UI 구현 (#12)` |
| `fix` | 버그 수정 | `fix: 앱 시작 시 크래시 수정 (#15)` |
| `refactor` | 동작 변경 없는 코드 구조 개선 | `refactor: AuthRepository 분리 (#20)` |
| `style` | 포맷팅, import 정리 등 (로직 변경 없음) | `style: dart format 적용 (#21)` |
| `design` | UI 스타일, 레이아웃, 에셋 변경 | `design: 홈 화면 여백 조정 (#22)` |
| `test` | 테스트 코드 추가/수정 | `test: 로그인 ViewModel 테스트 추가 (#23)` |
| `docs` | 문서 수정 | `docs: README 기여 가이드 작성 (#1)` |
| `chore` | 빌드, 패키지, 설정 변경 | `chore: cupertino_icons 버전 업데이트 (#3)` |
| `ci` | CI/CD 설정 변경 | `ci: PR 시 flutter analyze 실행 (#5)` |
| `rename` | 파일/폴더명 변경 또는 이동 | `rename: screens 폴더를 pages 로 변경 (#24)` |
| `remove` | 파일 삭제 | `remove: 사용하지 않는 에셋 삭제 (#25)` |

#### 2-3. 작성 규칙

- **subject**
  - 한글로 작성하고, 50자 이내로 간결하게 씁니다.
  - "~ 구현", "~ 수정", "~ 추가" 처럼 명사형으로 끝내고, 마침표를 붙이지 않습니다.
  - 끝에 관련 이슈 번호를 `(#이슈번호)` 로 붙입니다.
- **body**
  - header 와 한 줄 띄우고 작성합니다.
  - **무엇을, 왜** 변경했는지 씁니다. (어떻게는 코드로 확인 가능)
  - 한 줄은 72자 이내로 줄바꿈합니다.
- **footer**
  - 이슈 처리: `Close #12`, `Fixes #15`, `Ref #20`
  - 하위 호환이 깨지는 변경: `BREAKING CHANGE: <설명>`
- 하나의 커밋에는 하나의 변경 의도만 담습니다.

#### 2-4. 예시

```
feat: 소셜 로그인 버튼 추가 (#12)

- 카카오, 구글 로그인 버튼을 로그인 화면 하단에 추가
- 버튼 탭 시 각 SDK 로그인 플로우로 연결

Close #12
```

### 3. PR 메시지 컨벤션

#### 3-1. 제목

커밋 메시지 header 와 같은 형식으로 작성합니다.

```
<type>: <subject> (#이슈번호)
```

예시: `feat: 소셜 로그인 기능 구현 (#12)`

#### 3-2. 본문 템플릿

> PR 템플릿은 `.github/pull_request_template.md` 에 있으며, PR 생성 시 본문에 자동으로 채워집니다.

```markdown
## 📌 관련 이슈
- close #이슈번호

## ✨ 작업 내용
- 작업한 내용을 요약합니다.

## 📸 스크린샷 (UI 변경 시)
| Before | After |
| --- | --- |
|  |  |

## 💬 리뷰 요청 사항
- 리뷰어가 중점적으로 봐야 할 부분이나 고민한 점을 적습니다.

## ✅ 체크리스트
- [ ] `dart format .` 실행
- [ ] `flutter analyze` 경고/에러 없음
- [ ] `flutter test` 통과
- [ ] 관련 이슈 연결
- [ ] 셀프 리뷰 완료
```

#### 3-3. 작성 규칙

- base 브랜치는 `upstream/main` 입니다.
- 하나의 PR 에는 하나의 목적만 담고, 가능한 작은 단위로 올립니다.
- 작업 중인 PR 은 **Draft PR** 로 올리고, 리뷰 가능할 때 Ready for review 로 전환합니다.
- 담당자(Assignee)는 본인으로 지정합니다.
- 리뷰어는 `.github/CODEOWNERS` 에 따라 **메인테이너(`@Team-AnI/moamoa-reviewers`)가 자동으로 지정**됩니다. (작성자 본인 제외)
  - 메인테이너: @SangWook16074, @wjddns0122, @seongeunii, @yhKim26
  - 필요하면 다른 팀원을 리뷰어로 추가할 수 있습니다.
- 머지는 리뷰어 1명 이상 Approve 후, 작성자가 직접 합니다.

#### 3-4. CI (GitHub Actions)

PR 을 올리면 아래 검사가 자동으로 실행되며, **모두 통과해야 머지할 수 있습니다.**

| 워크플로우 | 검사 내용 | 실패 시 |
| --- | --- | --- |
| `CI / Format / Analyze / Test` | `dart format`, `flutter analyze`, `flutter test` | 로컬에서 같은 명령어로 확인 후 수정 |
| `CI / Build Android` | `flutter build apk --debug` | Gradle / 네이티브 설정 확인 |
| `PR Title / PR Title Convention` | PR 제목이 `<type>: <subject> (#이슈번호)` 형식인지 | PR 제목 수정 (재실행 자동) |

- 워크플로우 파일: `.github/workflows/`
- CI 의 Flutter 버전은 `ci.yml` 의 `FLUTTER_VERSION` 으로 고정되어 있으며, 요구 버전이 바뀌면 함께 수정합니다.

---

## 프로젝트 아키텍처

<!-- TODO: 폴더 구조, 레이어 구성, 상태 관리 방식 등을 작성합니다. -->

---

## 코드 컨벤션 가이드라인

<!-- TODO: 네이밍 규칙, 파일 구성, lint 규칙 등을 작성합니다. -->

---

## 기타

<!-- TODO: 환경 변수, 배포, 트러블슈팅 등 추가 섹션을 작성합니다. -->
