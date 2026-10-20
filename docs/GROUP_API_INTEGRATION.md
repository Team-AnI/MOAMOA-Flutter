# 모임 API 연동 (#29)

이 문서는 [기능별 API 연동 문서 템플릿](templates/FEATURE_API_INTEGRATION.md)의 작성 예시입니다.
템플릿은 리뷰를 위한 형식 제안이며, 생성자·DI 규칙은 별도 코드 스타일 가이드에서 다룹니다.

## 1. 기준과 의존성

- 관련 이슈: [#29](https://github.com/Team-AnI/MOAMOA-Flutter/issues/29)
- 기능 PR: [#39](https://github.com/Team-AnI/MOAMOA-Flutter/pull/39)
- 구현 기준: #39가 머지된 [c576488](https://github.com/Team-AnI/MOAMOA-Flutter/commit/c5764885277e8db3a55b313b58c5418f7d86d647)의 `develop` 코드
- 명세 기준: 2026-10-17 전달받은 모임·일정·공지 P0 초기 계약과 후순위 목록. 별도 버전 번호는 제공되지 않았습니다.
- 공유 엔티티 PR #35와 일정 PR #41을 반영한 기능 코드 기준입니다.

기능 PR #39는 `develop`에 머지됐습니다. 아래 기능·Provider·테스트 명령은 해당 모임 코드가 포함된 프로젝트 루트에서 실행합니다.
이 문서는 기능 코드나 서버 계약을 변경하지 않습니다.
[코드 스타일 가이드 #56](https://github.com/Team-AnI/MOAMOA-Flutter/pull/56)은 `main`의
[e711c5b](https://github.com/Team-AnI/MOAMOA-Flutter/commit/e711c5b2b94f20cd7b430cfd0b64cf075ada0feb)에 머지됐으며,
아래는 해당 가이드와 #39 구현 기준을 재대조한 결과입니다. `main` 머지가 `develop`의 기능 코드 변경을 뜻하지는 않습니다.

- 현재 일치하는 구조: core·feature Provider의 inline 선언, 명명된 DI 인자, Freezed Entity·Model·State, Model → Entity의 extension 변환입니다.
- 후속 코드 적용: 가이드는 DataSource 인자를 `XxxRequest` DTO로 받도록 명시하지만, #39 구현의 DataSource는 현재 문자열·정수 등 낱개 인자를 받습니다. 본 문서는 현재 구현을 기록하며 DTO 전환 코드를 추가하지 않습니다.
- 아직 확정되지 않은 정책: 가이드 2-3의 공통 예외와 2-4의 Repository 인자 형태는 여전히 결정 필요로 표시됩니다. family 인자와 테스트 설명 절차도 문서의 제안 표시를 유지합니다.
- #56의 `prefer_initializing_formals: false`는 `main` 설정이며, 이 문서 PR에서 `develop`의 lint 설정을 변경하지 않습니다.

## 2. API 범위와 구현 상태

아래의 ‘연결 코드 구현’은 클라이언트 코드 기준이며 실서버 검증 완료를 뜻하지 않습니다.

| 기능 | Method | Endpoint | 인증·권한 | 상태 |
| --- | --- | --- | --- | --- |
| 모임 생성 | POST | `/v1/meetings` | 로그인 사용자 | 연결 코드 구현 |
| 내 모임 목록 | GET | `/v1/me/meetings` | 로그인 사용자 | 연결 코드 구현 |
| 초대 코드 가입 | POST | `/v1/me/meetings` | 로그인 사용자 | 즉시 가입 코드 구현 |
| 모임 상세 | GET | `/v1/meetings/{meetingId}` | 해당 모임 MEMBER, ADMIN 포함 | 연결 코드 구현 |
| 초대 코드 조회 | GET | `/v1/meetings/{meetingId}/invite-code` | 해당 모임 ADMIN | 연결 코드 구현 |

모임 수정·삭제·구성원 목록·나가기는 전달 명세에 있지만 현재 #39에서는 구현하지 않았습니다.
가입 전 코드 미리보기와 승인 요청·승인/거절은 명세상 후순위입니다.

### 대표 요청·응답 예시

인증 헤더는 로그인 기능에서 별도 공급해야 합니다. 다음은 실제 호출 결과가 아닌 명세 예시입니다.

```http
POST /v1/meetings
Content-Type: application/json

{"name":"주말 러닝 크루","description":"매주 토요일 한강 러닝"}
```

성공 응답은 `201 Created`입니다.

```json
{
  "success": true,
  "data": {
    "meetingId": 1,
    "name": "주말 러닝 크루",
    "inviteCode": "A1B2C3D4",
    "myRole": "ADMIN"
  },
  "error": null,
  "timestamp": "2026-10-07T10:00:00+09:00"
}
```

현재 생성 코드에서는 모임 ID·이름·역할을 사용하고, 초대 코드는 생성 완료 화면에서 별도로 조회합니다.
가입 요청은 `inviteCode`를 보내며 목록은 `data.meetings`, 코드 조회는 `data.inviteCode`를 읽습니다.

## 3. 실행과 인증 설정

프로젝트 루트에서 실행합니다. 예시 주소는 실제 개발 서버 주소로 바꿔야 합니다.

```bash
flutter run --dart-define=API_BASE_URL=https://your-development-server
```

- `API_BASE_URL`: `/api` 같은 접두사는 유지하고 그 뒤에 `/v1/...`을 붙입니다. 주소에 이미 `/v1`이 있으면 중복되므로 기준 주소 확인이 필요합니다.
- `groupAuthHeadersProvider`: 로그인 기능에서 실제 인증 헤더를 override합니다. 기본값은 `null`이며 요청 전에 로그인 필요 오류로 처리합니다.
- `groupCurrentUserNameProvider`: 실제 계정 표시 이름을 주입합니다. 미연결 시 계정 정보 미연결로 표시합니다.
- 서버 주소가 없거나 유효하지 않으면 네트워크 요청을 보내지 않습니다.

실행 명령만으로 인증이 연결되지는 않습니다. Bearer 방식·토큰 저장 키는 이 기능에서 임의로 정하지 않습니다.

## 4. 데이터와 권한

| 서버 필드 | 앱 타입·대응 | 생략·null 처리 |
| --- | --- | --- |
| `meetingId` | `int`, `Group.id`·`GroupMember.groupId` | 응답 필수 |
| `name` | `String`, `Group.name` | 응답 필수 |
| `myRole` | `MemberRole.admin/member` | 알 수 없는 목록 역할은 제외, 상세·생성·가입의 잘못된 역할은 오류 |
| `description` | `String?`, `Group.description` | 목록에서 생략되면 `null`, 선택된 모임 갱신 시 기존 상세 소개 보존 |
| `memberCount` | `int?`, `Group.memberCount` | 생략 가능, 음수·잘못된 타입 거부 |
| `userId` | `int?`, `GroupMember.userId` | 현재 처리하는 응답에 없어 `null` 유지 |

`MeetingModel`에서 파싱하고 Repository가 공유 Entity로 변환합니다.
`Group`·`GroupMember`·`CurrentGroup`·`GroupState`는 Freezed 기반이며 권한 getter는 extension에 있습니다.
목록에서 모임을 선택하면 상세를 조회합니다. 서버 역할은 UI 표시 기준이며 최종 권한 검증은 서버 책임입니다.
구성원 목록 명세의 `memberId`는 별도 식별자이므로 `userId`로 취급하지 않습니다.

## 5. 주요 흐름과 오류

- 생성: 프로필·이름 → 소개·가입 방식 → 생성 요청 → 완료 화면·초대 코드 조회
- 가입: 코드 입력 → 즉시 가입 요청 → 가입 완료. 가입 전 모임 확인·승인 대기 단계는 제공하지 않습니다.
- 생성·가입: 목록 로딩·제출 중 버튼 비활성화 및 ViewModel 재진입 방지를 적용합니다.

| 오류 조건·코드 | 현재 처리 | 미확정·후속 확인 |
| --- | --- | --- |
| 공백 이름·코드 | UseCase에서 `GroupFailure(validation)` | 이름 UI 20자 제한은 Figma 기준이며 서버 상한 확인 필요 |
| 가입 `NOT_FOUND` | 유효하지 않은 코드 안내 | 상세 등 다른 호출의 404는 현재 일반 오류 |
| 가입 `CONFLICT` | 이미 가입한 모임 안내·기존 목록 이동 | 응답에 ID가 없어 자동 모임 선택 불가, #29 요구사항 조율 필요 |
| `UNAUTHORIZED` | 로그인 필요 안내 | 로그인 화면 연결 필요 |
| `FORBIDDEN` | 권한 오류로 분류 | 현재 문구는 초대 코드 관리자 안내에 고정되어 상세 접근 거부와 구분하는 후속 정리 필요 |
| 입력 오류 코드 | 검증 오류로 분류 | 공통 예외 정책 확정 후 변환 기준 대조 |
| 코드 없는 HTTP 실패 | 400·401·403·404·409로 보완 | 그 외 상태·네트워크·잘못된 응답은 일반 오류 |
| `JSON_PARSE_ERROR` 등 별도 미지원 코드 | 현재 일반 오류 | 전달 명세의 전역 오류와 공통 처리 정책 적용 검토 필요 |

멱등성 헤더나 자동 재시도는 임의로 추가하지 않았습니다.
클라이언트 중복 탭 방지가 서버의 중복 생성 방지를 보장하지는 않습니다.

## 6. 검증 방법과 결과

Fake Repository 또는 HTTP 어댑터를 주입해 검사합니다. 실서버 성공 검증과 구분합니다.
#39가 머지된 `develop` 기준 프로젝트 루트에서 실행합니다.

```bash
flutter analyze
flutter test
flutter test test/features/group/presentation/group_layout_test.dart --dart-define=GROUP_SCREENSHOTS=build/group-screens
```

- #39가 머지된 `develop` 기준으로 정적 분석 정상·모임과 일정 전체 테스트 **109개** 통과를 재확인했습니다.
- 상대 경로 캡처 명령은 macOS에서 테스트 **8개** 통과, PNG **24개** 생성을 확인했습니다. 이 명령은 파일을 생성하며 레이아웃 검증과 별개의 픽셀 단위 Figma 일치 검사는 아닙니다.
- 화면 크기: 393×852·320×568.
- PNG 경로: `build/group-screens/`. `build/`는 Git 추적에서 제외됩니다.
- Windows는 용현님(`yhKim26`)이 기준 커밋 `9fa6f2e`에서 PowerShell·Git Bash 모두 상대 경로 명령으로 테스트 **8개** 통과·PNG **24개** 생성과 `build/` Git 제외를 확인했다고 PR #49에 공유했습니다. 이 결과는 동료의 검증 보고이며, 문서 작성자가 Windows에서 직접 재실행한 결과는 아닙니다.
- 테스트 수는 기준 커밋의 결과이며 이후 변경에 따라 달라질 수 있습니다.
- 실서버 생성·가입·권한 검증은 미완료입니다. 서버 주소·인증 연동·테스트 계정이 필요합니다.

## 7. 미연결·후순위·확인 사항

| 항목 | 현재 상태 | 후속 작업·담당 확인 |
| --- | --- | --- |
| 링크 공유·첫 공지·첫 일정 | UI만 존재, 비활성 | 관련 명세·담당 기능 라우트 연결 |
| 홈 알림·구성원 전체 보기·일정·공지·회비·내 정보 | 미연결 | 담당 기능과 별도 연결 |
| 사진 선택 | 앨범·카메라·기본 복원 및 생성 입력 미리보기 | 실기기 촬영 확인, 업로드·서버 저장 명세 미제공 |
| 목록·홈 프로필 사진 | 기본 글자 아이콘 | 서버 이미지 필드·저장 기능 필요 |
| 모임 수정·삭제·구성원 목록·나가기 | 명세 있음, 현재 미구현 | 작은 후속 이슈·PR로 구분 |
| 관리자 나가기 | 명세상 불가, 422 | 관리자 양도는 후순위이며 현재 명세에서는 삭제만 가능 |
| 미리보기·승인 요청·승인/거절 | 후순위, 미구현 | 현재 즉시 가입과 구분 |
| QR·초대 링크 가입·코드 재발급·비활성화 | 미구현 | 후순위 계약·정책 확인 |
| 가이드 적용·미결정 정책 | #56 `main` 머지 후 재대조 완료 | DataSource Request DTO 전환은 후속 코드 작업, Repository 인자·공통 예외는 팀 결정 필요 |
| 이름 상한·오류 대응·서버 중복 방지 | 후속 확인 | #29 백엔드 담당자와 확인 |
| 전역 테마 | #39에서 제외, #55에서 별도 리뷰 | 폰트 의존성과 실제 화면 확인 |

`MemoryGroupRepository`·`GROUP_USE_MOCK`·`MOA-JOIN`·`MOA-WAIT` 앱 실행 경로는 제거됐습니다.
사진은 서버 전송·생성된 모임 저장을 하지 않으며, 취소 시 미리보기를 유지하고 권한 오류를 안내합니다.
이 문서는 미확정 정책을 확정하거나 #29를 완료 처리하는 근거가 아닙니다.
