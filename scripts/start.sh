#!/usr/bin/env bash
#
# 이슈 번호로 작업을 시작합니다.
#   - 최신 main 기준으로 컨벤션에 맞는 브랜치 생성 (<type>/#<이슈번호>-<설명>)
#   - 이슈 담당자(Assignee)를 본인으로 지정
#
# 사용법: scripts/start.sh <이슈번호> [설명] [옵션]   (자세한 내용: --help)

set -euo pipefail
source "$(dirname "$0")/lib.sh"

usage() {
  cat <<EOF
${BOLD}scripts/start.sh${RESET} - 이슈 번호로 작업 브랜치를 만들고 작업을 시작합니다.

${BOLD}사용법${RESET}
  scripts/start.sh <이슈번호> [설명] [옵션]

${BOLD}인자${RESET}
  이슈번호        작업할 GitHub 이슈 번호 (예: 12)
  설명            브랜치 이름 뒤에 붙을 영문 설명 (예: login-ui)
                  생략하면 입력을 요청합니다.

${BOLD}옵션${RESET}
  -t, --type <type>   브랜치 type 직접 지정 (feature | fix | refactor | chore | docs)
                      생략하면 이슈 제목의 [TYPE] 으로 자동 결정
  --no-assign         이슈 담당자를 지정하지 않음
  -n, --dry-run       실제로 실행하지 않고 실행할 명령어만 출력
  -h, --help          도움말

${BOLD}예시${RESET}
  scripts/start.sh 12 login-ui          # [FEAT] 이슈 → feature/#12-login-ui
  scripts/start.sh 15 crash-on-start    # [FIX] 이슈  → fix/#15-crash-on-start
  scripts/start.sh 20 auth -t refactor  # type 직접 지정 → refactor/#20-auth
  make start ISSUE=12 NAME=login-ui     # Makefile 로 실행
EOF
}

ISSUE=""; NAME=""; TYPE=""; ASSIGN=1; DRY_RUN=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)    usage; exit 0 ;;
    -t|--type)    TYPE="${2:-}"; shift 2 ;;
    --no-assign)  ASSIGN=0; shift ;;
    -n|--dry-run) DRY_RUN=1; shift ;;
    -*)           die "알 수 없는 옵션: $1 (도움말: --help)" ;;
    *)
      if [[ -z "$ISSUE" ]]; then ISSUE="$1"
      elif [[ -z "$NAME" ]]; then NAME="$1"
      else die "인자가 너무 많습니다: $1 (도움말: --help)"
      fi
      shift ;;
  esac
done
export DRY_RUN

[[ -n "$ISSUE" ]] || { usage; exit 1; }
ISSUE="${ISSUE#\#}"
[[ "$ISSUE" =~ ^[0-9]+$ ]] || die "이슈 번호는 숫자여야 합니다: $ISSUE"

cd "$(git rev-parse --show-toplevel)"
require_gh

# 1. 이슈 정보 확인
info "이슈 #$ISSUE 확인"
STATE="$(gh issue view "$ISSUE" -R "$REPO_SLUG" --json state -q .state 2>/dev/null)" \
  || die "이슈 #$ISSUE 를 찾을 수 없습니다. 먼저 이슈를 등록해주세요."
TITLE="$(gh issue view "$ISSUE" -R "$REPO_SLUG" --json title -q .title)"
echo "  #$ISSUE $TITLE"
[[ "$STATE" == "OPEN" ]] || warn "이슈가 열려 있지 않습니다. (상태: $STATE)"

# 2. 브랜치 이름 결정
if [[ -z "$TYPE" ]]; then
  TYPE="$(branch_type_for "$(issue_title_type "$TITLE")")"
fi
[[ "$TYPE" =~ ^(feature|fix|refactor|chore|docs)$ ]] \
  || die "브랜치 type 은 feature | fix | refactor | chore | docs 중 하나여야 합니다: $TYPE"

if [[ -z "$NAME" ]]; then
  [[ -t 0 ]] || die "브랜치 설명을 인자로 넘겨주세요. (예: scripts/start.sh $ISSUE login-ui)"
  read -r -p "브랜치 설명을 영문으로 입력하세요 (예: login-ui): " NAME
fi
# 공백 → '-', 소문자, 허용 문자만 남김
NAME="$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | tr ' _' '--' | sed 's/[^a-z0-9-]//g; s/--*/-/g; s/^-//; s/-$//')"
[[ -n "$NAME" ]] || die "브랜치 설명은 영문, 숫자, '-' 로 입력해주세요."

BRANCH="$TYPE/#$ISSUE-$NAME"
git check-ref-format --branch "$BRANCH" >/dev/null || die "올바르지 않은 브랜치 이름입니다: $BRANCH"
if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
  die "이미 있는 브랜치입니다: $BRANCH (이동: git switch '$BRANCH')"
fi

# 3. 작업 중인 변경사항 확인
if [[ -n "$(git status --porcelain --untracked-files=no)" ]]; then
  die "커밋하지 않은 변경사항이 있습니다. 커밋하거나 git stash 후 다시 실행해주세요."
fi

# 4. 최신 main 기준으로 브랜치 생성
REMOTE="$(team_remote)"
info "최신 $REMOTE/$BASE_BRANCH 기준으로 브랜치 생성"
run git fetch "$REMOTE" "$BASE_BRANCH"
run git switch -c "$BRANCH" "$REMOTE/$BASE_BRANCH" --no-track

# 5. 이슈 담당자 지정
if [[ "$ASSIGN" == "1" ]]; then
  info "이슈 #$ISSUE 담당자를 본인으로 지정"
  run gh issue edit "$ISSUE" -R "$REPO_SLUG" --add-assignee @me
fi

echo
ok "작업 준비 완료: ${BOLD}$BRANCH${RESET}"
echo "  커밋하면 메시지 끝에 (#$ISSUE) 가 자동으로 붙습니다. (git hooks 설치 시)"
echo "  작업이 끝나면: scripts/pr.sh"
