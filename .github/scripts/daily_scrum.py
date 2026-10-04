#!/usr/bin/env python3
"""
데일리 스크럼 Discord 알림

평일 오전 9시(KST)에 GitHub Actions(.github/workflows/daily-scrum.yml)에서 실행되어
Discord 웹훅으로 스크럼 안내 + 프로젝트 보드 요약 + 보드 이동 버튼을 보냅니다.

환경 변수
  DISCORD_SCRUM_WEBHOOK  (필수) Discord 웹훅 URL
  PROJECT_READ_TOKEN     (선택) 프로젝트 보드를 읽을 GitHub 토큰. 없으면 보드 요약 생략
  DISCORD_MENTION        (선택) 멘션. 역할 ID(숫자) / "here" / "everyone" / "none". 기본 "here"
  FORCE                  (선택) "true" 면 주말 / 공휴일에도 전송
  DRY_RUN                (선택) "true" 면 전송하지 않고 메시지 내용만 출력
"""

from __future__ import annotations

import datetime as dt
import json
import os
import sys
import urllib.error
import urllib.request
from collections import defaultdict

ORG = "Team-AnI"
PROJECT_NUMBER = 4
PROJECT_URL = f"https://github.com/orgs/{ORG}/projects/{PROJECT_NUMBER}"
MILESTONES_URL = f"https://github.com/{ORG}/MOAMOA-Flutter/milestones"
KST = dt.timezone(dt.timedelta(hours=9))
WEEKDAYS = ["월", "화", "수", "목", "금", "토", "일"]

# 보드 요약에 보여줄 상태 (순서대로)
SUMMARY_STATUSES = ["In Progress", "In Review"]
STATUS_EMOJI = {"In Progress": "🔨", "In Review": "👀", "Todo": "📋"}

EMBED_COLOR = 0x02569B  # Flutter blue


def env_flag(name: str) -> bool:
    return os.environ.get(name, "").strip().lower() in ("1", "true", "yes")


# ---------------------------------------------------------------------------
# 공휴일
# ---------------------------------------------------------------------------
def holiday_name(day: dt.date) -> str | None:
    """한국 공휴일이면 이름을, 아니면 None 을 반환합니다. (대체공휴일 포함)"""
    try:
        import holidays  # pip install holidays
    except ImportError:
        print("! holidays 패키지가 없어 공휴일 확인을 건너뜁니다.", file=sys.stderr)
        return None
    kr = holidays.country_holidays("KR", years=day.year, language="ko")
    return kr.get(day)


# ---------------------------------------------------------------------------
# 프로젝트 보드 요약
# ---------------------------------------------------------------------------
BOARD_QUERY = """
query($org: String!, $number: Int!, $cursor: String) {
  organization(login: $org) {
    projectV2(number: $number) {
      items(first: 100, after: $cursor) {
        pageInfo { hasNextPage endCursor }
        nodes {
          status: fieldValueByName(name: "Status") {
            ... on ProjectV2ItemFieldSingleSelectValue { name }
          }
          content {
            ... on Issue {
              number title url state
              assignees(first: 5) { nodes { login } }
              milestone { title dueOn }
            }
          }
        }
      }
    }
  }
}
"""


def fetch_board(token: str) -> list[dict]:
    """프로젝트 보드의 열린 이슈 목록을 가져옵니다."""
    items: list[dict] = []
    cursor = None
    while True:
        body = json.dumps({
            "query": BOARD_QUERY,
            "variables": {"org": ORG, "number": PROJECT_NUMBER, "cursor": cursor},
        }).encode()
        req = urllib.request.Request(
            "https://api.github.com/graphql",
            data=body,
            headers={"Authorization": f"Bearer {token}", "Content-Type": "application/json"},
        )
        with urllib.request.urlopen(req, timeout=20) as res:
            data = json.load(res)
        if data.get("errors"):
            raise RuntimeError(data["errors"][0].get("message", data["errors"]))

        page = data["data"]["organization"]["projectV2"]["items"]
        for node in page["nodes"]:
            issue = node.get("content") or {}
            if not issue.get("number") or issue.get("state") != "OPEN":
                continue
            items.append({
                "number": issue["number"],
                "title": issue["title"],
                "url": issue["url"],
                "status": (node.get("status") or {}).get("name") or "Todo",
                "assignees": [a["login"] for a in issue["assignees"]["nodes"]],
                "milestone": issue.get("milestone"),
            })
        if not page["pageInfo"]["hasNextPage"]:
            return items
        cursor = page["pageInfo"]["endCursor"]


def truncate(text: str, limit: int) -> str:
    return text if len(text) <= limit else text[: limit - 1] + "…"


def board_fields(items: list[dict], today: dt.date) -> list[dict]:
    """사람별 진행 중 / 리뷰 중 이슈를 Discord embed field 로 만듭니다."""
    by_person: dict[str, list[dict]] = defaultdict(list)
    for item in items:
        if item["status"] not in SUMMARY_STATUSES:
            continue
        for person in item["assignees"] or ["담당자 없음"]:
            by_person[person].append(item)

    fields = []
    for person in sorted(by_person, key=lambda p: (p == "담당자 없음", p.lower())):
        lines = []
        for item in sorted(by_person[person], key=lambda i: SUMMARY_STATUSES.index(i["status"])):
            line = f"{STATUS_EMOJI[item['status']]} [#{item['number']}]({item['url']}) {truncate(item['title'], 45)}"
            due = (item.get("milestone") or {}).get("dueOn")
            if due:
                left = (dt.date.fromisoformat(due[:10]) - today).days
                line += " `D-Day`" if left == 0 else (f" `D+{-left}`" if left < 0 else f" `D-{left}`")
            lines.append(line)
        value = "\n".join(lines)
        fields.append({"name": f"👤 {person}", "value": truncate(value, 1024), "inline": False})

    todo = sum(1 for i in items if i["status"] == "Todo")
    unassigned = sum(1 for i in items if i["status"] == "Todo" and not i["assignees"])
    if not fields:
        fields.append({"name": "📊 보드", "value": "진행 중이거나 리뷰 중인 이슈가 없습니다.", "inline": False})
    fields.append({
        "name": "📋 Todo",
        "value": f"{todo}개 (담당자 없음 {unassigned}개)" if todo else "없음",
        "inline": False,
    })
    return fields[:25]  # Discord embed field 최대 25개


# ---------------------------------------------------------------------------
# Discord 메시지
# ---------------------------------------------------------------------------
def mention_content() -> tuple[str, dict]:
    raw = os.environ.get("DISCORD_MENTION", "").strip() or "here"
    if raw.lower() == "none":
        return "", {"parse": []}
    if raw.lower() in ("here", "everyone"):
        return f"@{raw.lower()}", {"parse": ["everyone"]}
    role_id = raw.strip("<@&>")
    if role_id.isdigit():
        return f"<@&{role_id}>", {"roles": [role_id]}
    print(f"! DISCORD_MENTION 값을 이해할 수 없어 멘션을 생략합니다: {raw}", file=sys.stderr)
    return "", {"parse": []}


def build_message(today: dt.date, fields: list[dict] | None, board_error: str | None) -> dict:
    content, allowed = mention_content()
    description = (
        "플러터팀 데일리 스크럼 진행하겠습니다.\n"
        "**어제, 오늘 투두리스트** 공유해주세요! 🙌"
    )
    embed = {
        "title": "☀️ 플러터팀 데일리 스크럼",
        "url": PROJECT_URL,
        "description": description,
        "color": EMBED_COLOR,
        "footer": {"text": f"📅 {today.isoformat()} ({WEEKDAYS[today.weekday()]})  ·  MOAMOA"},
    }
    if fields:
        embed["fields"] = fields
    elif board_error:
        embed["fields"] = [{"name": "📊 보드", "value": f"보드 요약을 불러오지 못했습니다. ({board_error})", "inline": False}]

    return {
        "username": "MOAMOA Bot",
        "content": content,
        "allowed_mentions": allowed,
        "embeds": [embed],
        "components": [{
            "type": 1,  # Action Row
            "components": [
                {"type": 2, "style": 5, "label": "칸반 보드 열기", "emoji": {"name": "📋"}, "url": PROJECT_URL},
                {"type": 2, "style": 5, "label": "마일스톤", "emoji": {"name": "🗓"}, "url": MILESTONES_URL},
            ],
        }],
    }


def post(webhook: str, payload: dict) -> None:
    """웹훅으로 전송합니다. 링크 버튼이 거부되면 버튼 없이 다시 보냅니다."""
    def send(url: str, body: dict) -> None:
        req = urllib.request.Request(
            url,
            data=json.dumps(body).encode(),
            headers={"Content-Type": "application/json", "User-Agent": "MOAMOA-Bot (GitHub Actions)"},
        )
        urllib.request.urlopen(req, timeout=20).close()

    sep = "&" if "?" in webhook else "?"
    try:
        send(f"{webhook}{sep}with_components=true", payload)
    except urllib.error.HTTPError as e:
        if e.code != 400:
            raise
        print(f"! 버튼 전송이 거부되어 버튼 대신 본문 링크로 다시 보냅니다. ({e.read().decode()[:200]})", file=sys.stderr)
        payload = {k: v for k, v in payload.items() if k != "components"}
        embed = payload["embeds"][0]
        embed["description"] += f"\n\n📋 [칸반 보드 열기]({PROJECT_URL})  ·  🗓 [마일스톤]({MILESTONES_URL})"
        send(webhook, payload)


# ---------------------------------------------------------------------------
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

    # 2. 보드 요약
    fields, board_error = None, None
    token = os.environ.get("PROJECT_READ_TOKEN", "").strip()
    if token:
        try:
            fields = board_fields(fetch_board(token), today)
        except Exception as e:  # 보드 요약 실패해도 스크럼 알림은 보냄
            board_error = type(e).__name__
            print(f"! 보드 요약 실패: {e}", file=sys.stderr)
    else:
        print("! PROJECT_READ_TOKEN 이 없어 보드 요약을 생략합니다.", file=sys.stderr)

    payload = build_message(today, fields, board_error)

    # 3. 전송
    if dry_run:
        print(json.dumps(payload, ensure_ascii=False, indent=2))
        return 0
    webhook = os.environ.get("DISCORD_SCRUM_WEBHOOK", "").strip()
    if not webhook:
        print("✗ DISCORD_SCRUM_WEBHOOK 이 설정되지 않았습니다.", file=sys.stderr)
        return 1
    post(webhook, payload)
    print(f"✓ 데일리 스크럼 알림 전송 완료 ({today})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
