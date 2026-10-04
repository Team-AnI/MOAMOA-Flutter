#!/usr/bin/env bash
#
# scripts/*.sh 공통 함수. 직접 실행하지 않고 source 해서 사용합니다.

REPO_SLUG="Team-AnI/MOAMOA-Flutter"
BASE_BRANCH="main"

# 브랜치 이름 규칙: <type>/#<이슈번호>-<설명>
BRANCH_PATTERN='^(feature|fix|refactor|chore|docs)/#([0-9]+)-.+$'

if [[ -t 1 ]]; then
  RED=$'\033[31m'; GREEN=$'\033[32m'; YELLOW=$'\033[33m'; BLUE=$'\033[34m'; BOLD=$'\033[1m'; RESET=$'\033[0m'
else
  RED=""; GREEN=""; YELLOW=""; BLUE=""; BOLD=""; RESET=""
fi

info() { echo "${BLUE}==>${RESET} $*"; }
ok()   { echo "${GREEN}✓${RESET} $*"; }
warn() { echo "${YELLOW}!${RESET} $*"; }
die()  { echo "${RED}✗ $*${RESET}" >&2; exit 1; }

# 실행할 명령어를 출력하고, DRY_RUN=1 이면 실행하지 않습니다.
run() {
  echo "  ${BOLD}\$ $*${RESET}"
  if [[ "${DRY_RUN:-0}" != "1" ]]; then
    "$@"
  fi
}

require_gh() {
  command -v gh >/dev/null 2>&1 \
    || die "GitHub CLI(gh) 가 필요합니다. 설치: brew install gh && gh auth login"
  gh auth status >/dev/null 2>&1 \
    || die "gh 로그인이 필요합니다. 실행: gh auth login"
}

# Team-AnI 저장소를 가리키는 remote 이름 (origin / upstream 등)
team_remote() {
  local name
  for name in $(git remote); do
    if git remote get-url "$name" 2>/dev/null | grep -qi "$REPO_SLUG"; then
      echo "$name"
      return 0
    fi
  done
  die "$REPO_SLUG 를 가리키는 git remote 가 없습니다. (git remote add upstream https://github.com/$REPO_SLUG.git)"
}

# 이슈 제목 TYPE([FEAT] 등) → 브랜치 type
branch_type_for() {
  case "$1" in
    FEAT|DESIGN)        echo "feature" ;;
    FIX)                echo "fix" ;;
    REFACTOR)           echo "refactor" ;;
    DOCS)               echo "docs" ;;
    CHORE|CI|TEST|*)    echo "chore" ;;
  esac
}

# 이슈 제목 TYPE → 커밋 / PR type
commit_type_for() {
  case "$1" in
    FEAT)     echo "feat" ;;
    FIX)      echo "fix" ;;
    REFACTOR) echo "refactor" ;;
    DESIGN)   echo "design" ;;
    DOCS)     echo "docs" ;;
    TEST)     echo "test" ;;
    CI)       echo "ci" ;;
    *)        echo "chore" ;;
  esac
}

# 브랜치 type → 커밋 / PR type (이슈 제목에 TYPE 이 없을 때 사용)
commit_type_for_branch() {
  case "$1" in
    feature) echo "feat" ;;
    *)       echo "$1" ;;
  esac
}

# "[FEAT] 로그인 화면 구현" → "FEAT"
issue_title_type() {
  echo "$1" | sed -n 's/^\[\([A-Za-z]*\)\].*/\1/p' | tr '[:lower:]' '[:upper:]'
}

# "[FEAT] 로그인 화면 구현" → "로그인 화면 구현"
issue_title_subject() {
  echo "$1" | sed 's/^\[[A-Za-z]*\][[:space:]]*//'
}
