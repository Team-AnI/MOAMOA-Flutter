#!/usr/bin/env python3
"""
리뷰 대기 PR Discord 리마인드

평일 오전 10시(KST)에 GitHub Actions(.github/workflows/review-reminder.yml)에서 하루 1회 실행되어
아직 머지되지 않은 PR 전체를 메시지 하나로 모아 Discord 웹훅으로 리뷰 요청합니다.

리마인드 대상
  - Draft 가 아닌 열린(머지 / 닫힘 전) PR
  - 각 PR 의 리뷰 상태(승인 / 변경 요청 / 리뷰 대기)를 함께 표시

환경 변수
  DISCORD_GITHUB_WEBHOOK (필수) Discord 웹훅 URL
  GITHUB_TOKEN           (필수) PR 을 읽을 GitHub 토큰 (Actions 기본 토큰)
  GITHUB_REPOSITORY      (필수) owner/repo (Actions 가 자동 설정)
  FORCE                  (선택) "true" 면 주말 / 공휴일에도 전송
  DRY_RUN                (선택) "true" 면 전송하지 않고 메시지 내용만 출력
"""

from __future__ import annotations

import datetime as dt
import json
import os
import sys
import urllib.request

from daily_scrum import KST, USER_AGENT, env_flag, holiday_name, truncate

EMBED_COLOR = 0xF1C40F  # 노랑
REVIEW_STATE_LABELS = {"APPROVED": "✅ 승인", "CHANGES_REQUESTED": "🔁 변경 요청"}

PR_QUERY = """
query($owner: String!, $name: String!) {
  repository(owner: $owner, name: $name) {
    pullRequests(states: OPEN, first: 50, orderBy: {field: CREATED_AT, direction: ASC}) {
      nodes {
        number title url isDraft createdAt
        author { login }
        latestReviews(first: 20) { nodes { state } }
        reviewRequests(first: 10) {
          nodes { requestedReviewer { ... on User { login } ... on Team { name } } }
        }
        timelineItems(itemTypes: [READY_FOR_REVIEW_EVENT], last: 1) {
          nodes { ... on ReadyForReviewEvent { createdAt } }
        }
      }
    }
  }
}
"""


def parse_time(value: str) -> dt.datetime:
    return dt.datetime.fromisoformat(value.replace("Z", "+00:00"))


def fetch_pending_prs(token: str, repo: str, today: dt.date) -> list[dict]:
    """아직 머지되지 않은(Draft 제외) 열린 PR 목록을 반환합니다."""
    owner, name = repo.split("/", 1)
    req = urllib.request.Request(
        "https://api.github.com/graphql",
        data=json.dumps({"query": PR_QUERY, "variables": {"owner": owner, "name": name}}).encode(),
        headers={"Authorization": f"Bearer {token}", "Content-Type": "application/json"},
    )
    with urllib.request.urlopen(req, timeout=20) as res:
        data = json.load(res)
    if data.get("errors"):
        raise RuntimeError(data["errors"][0].get("message", data["errors"]))

    pending = []
    for pr in data["data"]["repository"]["pullRequests"]["nodes"]:
        if pr["isDraft"]:
            continue
        ready_events = pr["timelineItems"]["nodes"]
        opened_at = parse_time(ready_events[-1]["createdAt"] if ready_events else pr["createdAt"])
        opened_day = opened_at.astimezone(KST).date()
        states = {r["state"] for r in pr["latestReviews"]["nodes"]}
        if "CHANGES_REQUESTED" in states:
            review = REVIEW_STATE_LABELS["CHANGES_REQUESTED"]
        elif "APPROVED" in states:
            review = REVIEW_STATE_LABELS["APPROVED"]
        else:
            review = "⏳ 리뷰 대기"
        reviewers = [
            r["requestedReviewer"].get("login") or r["requestedReviewer"].get("name")
            for r in pr["reviewRequests"]["nodes"]
            if r.get("requestedReviewer")
        ]
        pending.append({
            "number": pr["number"],
            "title": pr["title"],
            "url": pr["url"],
            "author": (pr.get("author") or {}).get("login", "알 수 없음"),
            "reviewers": [r for r in reviewers if r],
            "days": (today - opened_day).days,
            "review": review,
        })
    return pending


def build_message(prs: list[dict]) -> dict:
    lines = []
    for pr in prs:
        line = f"• [#{pr['number']}]({pr['url']}) {truncate(pr['title'], 60)}\n"
        opened = f"Open 후 {pr['days']}일째" if pr["days"] else "오늘 Open"
        line += f"  └ {pr['review']} · 작성자 {pr['author']} · {opened}"
        if pr["reviewers"]:
            line += f" · 리뷰어 {', '.join(pr['reviewers'])}"
        lines.append(line)
    return {
        "username": "MOAMOA Bot",
        "content": "@here 아직 머지되지 않은 PR이 있습니다. 리뷰 부탁드립니다.",
        "allowed_mentions": {"parse": ["everyone"]},
        "embeds": [{
            "title": f"👀 머지 대기 PR {len(prs)}개",
            "description": truncate("\n".join(lines), 4096),
            "color": EMBED_COLOR,
        }],
    }


def post(webhook: str, payload: dict) -> None:
    req = urllib.request.Request(
        webhook,
        data=json.dumps(payload).encode(),
        headers={"Content-Type": "application/json", "User-Agent": USER_AGENT},
    )
    urllib.request.urlopen(req, timeout=20).close()


def main() -> int:
    today = dt.datetime.now(KST).date()
    force = env_flag("FORCE")
    dry_run = env_flag("DRY_RUN")

    # 1. 주말 / 공휴일 확인
    if not force:
        if today.weekday() >= 5:
            print(f"주말({today})이라 전송하지 않습니다.")
            return 0
        name = holiday_name(today)
        if name:
            print(f"공휴일({today} {name})이라 전송하지 않습니다.")
            return 0

    # 2. 머지 대기 PR 조회
    token = os.environ.get("GITHUB_TOKEN", "").strip()
    repo = os.environ.get("GITHUB_REPOSITORY", "").strip()
    if not token or not repo:
        print("✗ GITHUB_TOKEN / GITHUB_REPOSITORY 가 설정되지 않았습니다.", file=sys.stderr)
        return 1
    prs = fetch_pending_prs(token, repo, today)
    if not prs:
        print("머지 대기 중인 PR 이 없어 전송하지 않습니다.")
        return 0

    payload = build_message(prs)

    # 3. 전송
    if dry_run:
        print(json.dumps(payload, ensure_ascii=False, indent=2))
        return 0
    webhook = os.environ.get("DISCORD_GITHUB_WEBHOOK", "").strip()
    if not webhook:
        print("✗ DISCORD_GITHUB_WEBHOOK 이 설정되지 않았습니다.", file=sys.stderr)
        return 1
    post(webhook, payload)
    print(f"✓ 머지 대기 PR {len(prs)}개 리마인드 전송 완료 ({today})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
