# MOAMOA 개발 명령어 모음
# 사용법: make <명령어>   (목록: make 또는 make help)

.DEFAULT_GOAL := help
.PHONY: help setup hooks get check format format-check analyze test clean run build-apk start pr pr-draft

help: ## 사용 가능한 명령어 목록
	@echo "사용법: make <명령어>"
	@echo
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

# ---------------------------------------------------------------------------
# 환경 세팅
# ---------------------------------------------------------------------------
setup: ## 개발 환경 점검 + 의존성 설치 + git hooks 설치
	@./moamoa-flutter-setup.sh

hooks: ## git hooks 설치 (커밋 메시지 자동완성/검사, push 전 검사)
	@git config core.hooksPath .githooks
	@chmod +x .githooks/*
	@echo "✓ git hooks 설치 완료 (.githooks)"

get: ## 의존성 설치 (flutter pub get)
	flutter pub get

# ---------------------------------------------------------------------------
# 검사 (CI 와 동일)
# ---------------------------------------------------------------------------
check: format-check analyze test ## CI 와 같은 검사 전체 실행 (format + analyze + test)
	@echo "✓ 모든 검사 통과"

format: ## 코드 포맷 자동 수정 (dart format .)
	dart format .

format-check: ## 포맷 검사만 (수정하지 않음)
	dart format --output=none --set-exit-if-changed .

analyze: ## 정적 분석 (flutter analyze)
	flutter analyze

test: ## 테스트 실행 (flutter test)
	flutter test

# ---------------------------------------------------------------------------
# 실행 / 빌드
# ---------------------------------------------------------------------------
run: ## 앱 실행 (flutter run)
	flutter run

build-apk: ## Android debug APK 빌드
	flutter build apk --debug

clean: ## 빌드 캐시 삭제 후 의존성 재설치 (빌드가 꼬였을 때)
	flutter clean
	flutter pub get

# ---------------------------------------------------------------------------
# 작업 흐름 (이슈 → 브랜치 → PR)
# ---------------------------------------------------------------------------
start: ## 이슈로 작업 시작  예) make start ISSUE=12 NAME=login-ui
	@test -n "$(ISSUE)" || (echo "사용법: make start ISSUE=<이슈번호> NAME=<영문설명>"; exit 1)
	@./scripts/start.sh $(ISSUE) $(NAME)

pr: ## 현재 브랜치로 PR 생성 (리뷰어 자동 지정, 추가: REVIEWER=아이디)
	@./scripts/pr.sh $(if $(REVIEWER),-r $(REVIEWER))

pr-draft: ## 현재 브랜치로 Draft PR 생성
	@./scripts/pr.sh --draft $(if $(REVIEWER),-r $(REVIEWER))
