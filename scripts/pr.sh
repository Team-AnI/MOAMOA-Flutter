#!/usr/bin/env bash
#
# 현재 브랜치로 컨벤션에 맞는 PR 을 생성합니다.
#   - 브랜치 push
#   - PR 제목: <type>: <subject> (#이슈번호)  (이슈 제목에서 자동 생성)
#   - PR 본문: PR 템플릿 + close #이슈번호 자동 입력
#   - 담당자(Assignee): 본인
#
# 사용법: scripts/pr.sh [옵션]   (자세한 내용: --help)

set -euo pipefail
source "$(dirname "$0")/lib.sh"

usage() {
  cat <<EOF
${BOLD}scripts/pr.sh${RESET} - 현재 브랜치로 컨벤션에 맞는 PR 을 생성합니다.

${BOLD}사용법${RESET}
  scripts/pr.sh [옵션]

${BOLD}옵션${RESET}
  -d, --draft               Draft PR 로 생성 (작업 중일 때)
  -r, --reviewer <id,...>   리뷰어 추가 지정 (GitHub 아이디, 쉼표로 여러 명)
                            메인테이너는 CODEOWNERS 로 자동 지정되므로 생략 가능
  -T, --title <제목>        PR 제목의 subject 직접 지정 (기본: 이슈 제목)
  -w, --web                 PR 생성 후 브라우저로 열기
  -n, --dry-run             실제로 실행하지 않고 실행할 명령어만 출력
  -h, --help                도움말

${BOLD}예시${RESET}
  scripts/pr.sh                       # 브랜치 feature/#12-login-ui, 이슈 "[FEAT] 로그인 화면 구현"
                                      # → PR 제목 "feat: 로그인 화면 구현 (#12)"
  scripts/pr.sh -d                    # Draft PR
  scripts/pr.sh -r gsmin02,stdiodh    # 메인테이너 외 리뷰어 추가
  make pr                             # Makefile 로 실행
EOF
}

DRAFT=0; REVIEWERS=""; SUBJECT=""; WEB=0; DRY_RUN=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)     usage; exit 0 ;;
    -d|--draft)    DRAFT=1; shift ;;
    -r|--reviewer) REVIEWERS="${2:-}"; shift 2 ;;
    -T|--title)    SUBJECT="${2:-}"; shift 2 ;;
    -w|--web)      WEB=1; shift ;;
    -n|--dry-run)  DRY_RUN=1; shift ;;
    *)             die "알 수 없는 옵션: $1 (도움말: --help)" ;;
  esac
done
export DRY_RUN

cd "$(git rev-parse --show-toplevel)"
require_gh

# 1. 브랜치 확인
BRANCH="$(git branch --show-current)"
[[ "$BRANCH" =~ $BRANCH_PATTERN ]] \
  || die "브랜치 이름이 컨벤션과 다릅니다: '$BRANCH' (형식: <type>/#<이슈번호>-<설명>, 생성: scripts/start.sh)"
BRANCH_TYPE="${BASH_REMATCH[1]}"
ISSUE="${BASH_REMATCH[2]}"

if [[ -n "$(git status --porcelain --untracked-files=no)" ]]; then
  warn "커밋하지 않은 변경사항이 있습니다. PR 에는 포함되지 않습니다."
fi

REMOTE="$(team_remote)"
git fetch --quiet "$REMOTE" "$BASE_BRANCH"
if [[ "$(git rev-list --count "$REMOTE/$BASE_BRANCH..HEAD")" == "0" ]]; then
  die "$BASE_BRANCH 대비 새 커밋이 없습니다. 커밋 후 다시 실행해주세요."
fi

# 2. 이미 PR 이 있는지 확인
EXISTING="$(gh pr list -R "$REPO_SLUG" --head "$BRANCH" --state open --json url -q '.[0].url' 2>/dev/null || true)"
if [[ -n "$EXISTING" ]]; then
  info "이미 열린 PR 이 있어 브랜치만 push 합니다."
  run git push "$REMOTE" "$BRANCH"
  ok "PR: $EXISTING"
  exit 0
fi

# 3. PR 제목 만들기
ISSUE_TITLE="$(gh issue view "$ISSUE" -R "$REPO_SLUG" --json title -q .title 2>/dev/null)" \
  || die "이슈 #$ISSUE 를 찾을 수 없습니다."
ISSUE_TYPE="$(issue_title_type "$ISSUE_TITLE")"
if [[ -n "$ISSUE_TYPE" ]]; then
  PR_TYPE="$(commit_type_for "$ISSUE_TYPE")"
else
  PR_TYPE="$(commit_type_for_branch "$BRANCH_TYPE")"
fi
[[ -n "$SUBJECT" ]] || SUBJECT="$(issue_title_subject "$ISSUE_TITLE")"
PR_TITLE="$PR_TYPE: $SUBJECT (#$ISSUE)"

# 4. PR 본문 만들기 (템플릿의 '#이슈번호' 를 실제 번호로 치환)
TEMPLATE=".github/pull_request_template.md"
BODY_FILE="$(mktemp)"
trap 'rm -f "$BODY_FILE"' EXIT
if [[ -f "$TEMPLATE" ]]; then
  sed "s/#이슈번호/#$ISSUE/g" "$TEMPLATE" > "$BODY_FILE"
else
  printf '## 📌 관련 이슈\n- close #%s\n\n## ✨ 작업 내용\n- \n' "$ISSUE" > "$BODY_FILE"
fi
{
  echo
  echo "<!-- 커밋 목록 (작업 내용 작성 시 참고, 필요 없으면 지워주세요)"
  git log --reverse --format='- %s' "$REMOTE/$BASE_BRANCH..HEAD"
  echo "-->"
} >> "$BODY_FILE"

info "PR 생성"
echo "  제목: ${BOLD}$PR_TITLE${RESET}"
echo "  브랜치: $BRANCH → $BASE_BRANCH"

# 5. push + PR 생성
run git push -u "$REMOTE" "$BRANCH"

ARGS=(pr create -R "$REPO_SLUG" --base "$BASE_BRANCH" --head "$BRANCH"
      --title "$PR_TITLE" --body-file "$BODY_FILE" --assignee @me)
[[ "$DRAFT" == "1" ]] && ARGS+=(--draft)
[[ -n "$REVIEWERS" ]] && ARGS+=(--reviewer "$REVIEWERS")
run gh "${ARGS[@]}"

if [[ "$WEB" == "1" && "$DRY_RUN" != "1" ]]; then
  gh pr view "$BRANCH" -R "$REPO_SLUG" --web
fi

echo
ok "PR 생성 완료"
echo "  PR 본문의 '작업 내용', '리뷰 요청 사항' 을 채워주세요. (gh pr edit --body-file 또는 웹에서 수정)"
echo "  리뷰어: 메인테이너(@Team-AnI/moamoa-reviewers)가 CODEOWNERS 로 자동 지정됩니다.${REVIEWERS:+ (추가: $REVIEWERS)}"
