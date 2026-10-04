#!/usr/bin/env bash
#
# MOAMOA Flutter 개발 환경 세팅 스크립트
#
# 사용법:
#   ./moamoa-flutter-setup.sh            # 환경 점검 + 의존성 설치
#   ./moamoa-flutter-setup.sh --check    # 환경 점검만 (설치/변경 없음)
#
# 하는 일:
#   1. Flutter / Dart / JDK / (macOS) Xcode, CocoaPods 버전 점검
#   2. upstream remote 등록 (없을 경우)
#   3. git hooks 설치, GitHub CLI 확인
#   4. flutter pub get
#   5. (macOS) pod install
#   6. flutter doctor 결과 출력

set -euo pipefail

# ---------------------------------------------------------------------------
# 프로젝트 요구 버전 (README 의 "요구 버전" 표와 함께 갱신해주세요)
# ---------------------------------------------------------------------------
REQUIRED_FLUTTER_VERSION="3.44.9"
REQUIRED_DART_VERSION="3.12.2"
REQUIRED_JAVA_MAJOR="17"
UPSTREAM_URL="https://github.com/Team-AnI/MOAMOA-Flutter.git"

CHECK_ONLY=false
if [[ "${1:-}" == "--check" ]]; then
  CHECK_ONLY=true
elif [[ $# -gt 0 ]]; then
  echo "알 수 없는 옵션: $1"
  echo "사용법: $0 [--check]"
  exit 1
fi

# ---------------------------------------------------------------------------
# 출력 헬퍼
# ---------------------------------------------------------------------------
if [[ -t 1 ]]; then
  RED=$'\033[31m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; BLUE=$'\033[34m'; RESET=$'\033[0m'
else
  RED=""; GREEN=""; YELLOW=""; BLUE=""; RESET=""
fi

ERRORS=0
WARNINGS=0

step() { echo; echo "${BLUE}==> $*${RESET}"; }
ok()   { echo "  ${GREEN}✓${RESET} $*"; }
warn() { echo "  ${YELLOW}!${RESET} $*"; WARNINGS=$((WARNINGS + 1)); }
fail() { echo "  ${RED}✗${RESET} $*"; ERRORS=$((ERRORS + 1)); }

# 스크립트 위치(프로젝트 루트)에서 실행
cd "$(dirname "$0")"

if [[ ! -f pubspec.yaml ]]; then
  echo "${RED}pubspec.yaml 을 찾을 수 없습니다. 프로젝트 루트에서 실행해주세요.${RESET}"
  exit 1
fi

IS_MACOS=false
[[ "$(uname -s)" == "Darwin" ]] && IS_MACOS=true

# ---------------------------------------------------------------------------
# 1. Flutter / Dart
# ---------------------------------------------------------------------------
step "Flutter / Dart 확인"

if ! command -v flutter >/dev/null 2>&1; then
  fail "flutter 명령어를 찾을 수 없습니다."
  echo "    설치 가이드: https://docs.flutter.dev/get-started/install"
  echo
  echo "${RED}Flutter 가 없어 세팅을 진행할 수 없습니다.${RESET}"
  exit 1
fi

FLUTTER_VERSION_OUTPUT="$(flutter --version 2>/dev/null)"
FLUTTER_VERSION="$(echo "$FLUTTER_VERSION_OUTPUT" | sed -n 's/^Flutter \([^ ]*\).*/\1/p' | head -n 1)"
DART_VERSION="$(echo "$FLUTTER_VERSION_OUTPUT" | sed -n 's/.*Dart \([^ ]*\).*/\1/p' | head -n 1)"

if [[ "$FLUTTER_VERSION" == "$REQUIRED_FLUTTER_VERSION" ]]; then
  ok "Flutter $FLUTTER_VERSION"
else
  warn "Flutter ${FLUTTER_VERSION:-알 수 없음} (요구 버전: $REQUIRED_FLUTTER_VERSION)"
  echo "    버전 맞추기: flutter channel stable && flutter upgrade"
  echo "    또는 Flutter SDK 디렉터리에서: git checkout $REQUIRED_FLUTTER_VERSION && flutter --version"
fi

if [[ "$DART_VERSION" == "$REQUIRED_DART_VERSION" ]]; then
  ok "Dart $DART_VERSION"
else
  warn "Dart ${DART_VERSION:-알 수 없음} (요구 버전: $REQUIRED_DART_VERSION)"
fi

# ---------------------------------------------------------------------------
# 2. JDK (Android)
# ---------------------------------------------------------------------------
step "JDK 확인 (Android 빌드용)"

# Flutter 가 사용하는 JDK 를 우선 확인하고, 없으면 PATH 의 java 를 확인
JAVA_VERSION_LINE="$(flutter doctor -v 2>/dev/null | grep -m 1 'Java version' || true)"
if [[ -z "$JAVA_VERSION_LINE" ]] && command -v java >/dev/null 2>&1; then
  JAVA_VERSION_LINE="$(java -version 2>&1 | head -n 1)"
fi

JAVA_MAJOR="$(echo "$JAVA_VERSION_LINE" | grep -oE '[0-9]+(\.[0-9]+)*' | head -n 1 | cut -d. -f1 || true)"

if [[ -z "$JAVA_MAJOR" ]]; then
  warn "JDK 를 찾을 수 없습니다. Android Studio 설치 또는 JDK $REQUIRED_JAVA_MAJOR 설치가 필요합니다."
elif [[ "$JAVA_MAJOR" == "$REQUIRED_JAVA_MAJOR" ]]; then
  ok "JDK $JAVA_MAJOR"
else
  warn "JDK $JAVA_MAJOR (요구 버전: $REQUIRED_JAVA_MAJOR)"
  echo "    설정: flutter config --jdk-dir <JDK_${REQUIRED_JAVA_MAJOR}_경로>"
fi

# ---------------------------------------------------------------------------
# 3. Xcode / CocoaPods (macOS)
# ---------------------------------------------------------------------------
if $IS_MACOS; then
  step "Xcode / CocoaPods 확인 (iOS 빌드용)"

  if command -v xcodebuild >/dev/null 2>&1 && xcodebuild -version >/dev/null 2>&1; then
    ok "$(xcodebuild -version | head -n 1)"
  else
    warn "Xcode 가 설치되어 있지 않거나 설정되지 않았습니다."
    echo "    sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer"
    echo "    sudo xcodebuild -runFirstLaunch"
  fi

  if command -v pod >/dev/null 2>&1; then
    ok "CocoaPods $(pod --version)"
  else
    warn "CocoaPods 가 설치되어 있지 않습니다. (설치: brew install cocoapods)"
  fi
fi

# ---------------------------------------------------------------------------
# 4. Git remote
# ---------------------------------------------------------------------------
step "Git remote 확인"

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if git remote get-url upstream >/dev/null 2>&1; then
    ok "upstream: $(git remote get-url upstream)"
  elif $CHECK_ONLY; then
    warn "upstream remote 가 없습니다. (git remote add upstream $UPSTREAM_URL)"
  else
    git remote add upstream "$UPSTREAM_URL"
    ok "upstream remote 등록: $UPSTREAM_URL"
  fi
else
  warn "git 저장소가 아닙니다."
fi

# ---------------------------------------------------------------------------
# 4-1. 자동화 도구 (git hooks / GitHub CLI)
# ---------------------------------------------------------------------------
step "자동화 도구 확인"

if git rev-parse --is-inside-work-tree >/dev/null 2>&1 && [[ -d .githooks ]]; then
  if [[ "$(git config core.hooksPath || true)" == ".githooks" ]]; then
    ok "git hooks 설치됨 (.githooks)"
  elif $CHECK_ONLY; then
    warn "git hooks 가 설치되어 있지 않습니다. (설치: make hooks)"
  else
    git config core.hooksPath .githooks
    chmod +x .githooks/*
    ok "git hooks 설치 완료 (.githooks)"
  fi
fi

if command -v gh >/dev/null 2>&1; then
  if gh auth status >/dev/null 2>&1; then
    ok "GitHub CLI $(gh --version | head -n 1 | awk '{print $3}') (로그인됨)"
  else
    warn "GitHub CLI 로그인이 필요합니다. (gh auth login)"
  fi
else
  warn "GitHub CLI(gh) 가 없습니다. scripts/start.sh, scripts/pr.sh 에 필요합니다. (설치: brew install gh)"
fi

# ---------------------------------------------------------------------------
# 5. 의존성 설치
# ---------------------------------------------------------------------------
if $CHECK_ONLY; then
  step "의존성 설치 건너뜀 (--check)"
else
  step "flutter pub get"
  if flutter pub get; then
    ok "Dart 패키지 설치 완료"
  else
    fail "flutter pub get 실패"
  fi

  if $IS_MACOS && command -v pod >/dev/null 2>&1 && [[ -f ios/Podfile ]]; then
    step "pod install"
    if (cd ios && pod install); then
      ok "iOS Pod 설치 완료"
    else
      fail "pod install 실패 (pod repo update 후 재시도해보세요)"
    fi
  fi
fi

# ---------------------------------------------------------------------------
# 6. flutter doctor
# ---------------------------------------------------------------------------
step "flutter doctor"
flutter doctor || true

# ---------------------------------------------------------------------------
# 결과
# ---------------------------------------------------------------------------
echo
if [[ $ERRORS -gt 0 ]]; then
  echo "${RED}세팅 실패: 오류 ${ERRORS}개, 경고 ${WARNINGS}개${RESET}"
  exit 1
elif [[ $WARNINGS -gt 0 ]]; then
  echo "${YELLOW}세팅 완료 (경고 ${WARNINGS}개) - 위의 경고 항목을 확인해주세요.${RESET}"
else
  echo "${GREEN}세팅 완료! 'flutter run' 으로 앱을 실행해보세요.${RESET}"
fi
