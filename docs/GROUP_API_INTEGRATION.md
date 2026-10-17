# 모임 API 연동 (#29)

## 문서 기준과 의존성

이 문서는 기능 PR [#39](https://github.com/Team-AnI/MOAMOA-Flutter/pull/39)의
`9fa6f2e` 구현 기준으로 작성했습니다. 해당 기능이 아직 머지되지 않은 develop에서는
아래 기능과 Provider를 바로 사용할 수 없습니다. 기능 PR과 함께 검토합니다.
공유 엔티티 PR #35는 머지됐습니다. 이 문서 PR은 기능 코드나 서버 계약을 변경하지 않습니다.

## API 구현 범위

| 기능 | 메서드 | 경로 |
| --- | --- | --- |
| 모임 생성 | POST | `/v1/meetings` |
| 내 모임 목록 | GET | `/v1/me/meetings` |
| 초대 코드 가입 | POST | `/v1/me/meetings` |
| 모임 상세 | GET | `/v1/meetings/{meetingId}` |
| 초대 코드 조회 | GET | `/v1/meetings/{meetingId}/invite-code` |

생성 요청은 name과 선택 description, 가입 요청은 inviteCode를 사용합니다.
현재 구현은 success/data/error 응답 envelope와 meetingId/myRole 필드를 처리합니다.
목록은 data.meetings, 코드 조회는 data.inviteCode를 읽습니다.
가입 전 모임 조회와 승인 요청 API는 구현되어 있지 않아 코드 입력 후 바로 가입합니다.

DataSource는 기능별 메서드로 API를 호출하고 MeetingModel을 반환합니다.
Repository는 Model을 Entity로 변환하고 API 오류를 도메인 오류로 분류합니다.
UseCase는 입력 검증과 권한 확인을 담당하고 Riverpod ViewModel은 화면 상태를 관리합니다.
Provider는 팀 가이드에 따라 core를 포함해 inline 방식으로 선언합니다.

## 실행 및 인증 설정

```bash
flutter run --dart-define=API_BASE_URL=https://your-development-server
```

예시 주소는 실제 개발 서버 주소로 바꿔야 합니다.
주소에 `/api` 같은 경로 접두사가 있으면 그 뒤에 `/v1/...`을 붙입니다.
이미 `/v1`이 포함된 주소는 버전 경로가 중복되므로 서버 기준 주소를 확인해야 합니다.

로그인 기능에서 groupAuthHeadersProvider를 override해 실제 인증 헤더를 공급합니다.
기본값은 null이며 인증 헤더가 없으면 요청 전에 로그인 필요 오류로 처리합니다.
서버 주소가 없거나 유효하지 않으면 네트워크 요청을 보내지 않습니다.
인증 방식·토큰 저장 키는 이 기능에서 임의로 정하지 않습니다.
groupCurrentUserNameProvider에는 실제 계정 표시 이름을 주입해야 합니다.
미연결 상태는 계정 정보 미연결로 표시합니다.

## 공유 데이터와 권한

모임 ID는 int, 역할은 공유 MemberRole의 admin/member를 사용합니다.
Group, GroupMember, CurrentGroup은 Freezed 기반이며 권한 getter는 extension에 있습니다.
현재 처리하는 API 응답에는 userId가 없어 GroupMember.userId는 nullable입니다.
소개도 nullable이며 목록에서 누락된 소개는 null입니다.
선택된 모임을 목록으로 갱신할 때는 기존 상세 소개를 보존합니다.
목록에서 모임을 선택하면 상세를 조회합니다.
알 수 없는 역할의 목록 항목은 제외하며 관리자 권한으로 추측하지 않습니다.
서버 역할을 UI 표시 기준으로 사용하고 최종 접근 권한은 서버에서 검증해야 합니다.

## 입력·오류·중복 제출

UseCase는 공백 이름과 공백 초대 코드를 GroupFailure(validation)로 거부합니다.
이름 입력 UI는 현재 Figma 기준 20자 제한을 사용하지만 백엔드 상한 확인은 남아 있습니다.

가입의 NOT_FOUND는 유효하지 않은 코드, CONFLICT는 이미 가입한 모임으로 분류합니다.
409 응답에 meetingId가 없어 해당 모임을 자동 선택하지 않고 기존 목록 이동을 안내합니다.
UNAUTHORIZED/FORBIDDEN과 입력 오류도 분류하며, 오류 본문에 코드가 없으면
HTTP 상태 코드로 보완합니다. 미지원 코드·네트워크·잘못된 응답은 일반 오류로 표시합니다.
서버 오류 코드 전체와 예외 정책은 백엔드 담당자 확인이 필요한 상태입니다.

목록 로딩 및 제출 중에는 생성·가입 제출 버튼을 비활성화하고 재진입을 막습니다.
멱등성 헤더와 자동 재시도는 서버 계약이 없어 추가하지 않았습니다.
클라이언트 중복 탭 방지가 서버의 중복 생성 방지를 보장하지는 않습니다.

## 화면과 미연결 범위

- 내 모임 목록·빈 상태·추가 시트, 2단계 모임 생성, 생성 완료를 제공합니다.
- 생성 완료에서 코드 복사·내 모임 목록·모임 홈 이동을 연결했습니다.
- 기본 홈은 모임 헤더·구성원 수 카드·하단 탭으로 구성됩니다.
- 관리자 설정 메뉴의 초대 코드 조회를 연결했습니다.
- 링크 공유·첫 공지 쓰기·첫 일정 만들기는 연결 전 비활성 상태입니다.
- 홈의 알림·구성원 전체 보기·일정·공지·회비·내 정보는 담당 기능과 연결이 필요합니다.
- 승인 후 가입·승인 대기·승인/거절은 현재 서버 연동 범위에 없습니다.
- QR·초대 링크 가입·코드 만료·재발급·폐기는 구현하지 않았습니다.

사진 선택은 image_picker로 앨범·카메라와 연결하고 생성 입력 단계에서만 미리 봅니다.
취소 시 이전 사진을 유지하고 권한 오류를 안내합니다. 카메라 촬영은 실제 기기 검증이 필요합니다.
이미지 필드·업로드 API가 없어 사진을 서버에 전송하거나 생성된 모임에 저장하지 않습니다.
따라서 내 모임 목록·홈은 기본 글자 아이콘을 사용합니다.

개발용 MemoryGroupRepository와 GROUP_USE_MOCK 실행 경로는 #39 리뷰 반영 과정에서 제거했습니다.
이전 MOA-JOIN/MOA-WAIT 테스트 코드는 앱 실행용으로 제공되지 않습니다.
전역 테마 변경도 #39에서 제외됐으며 별도 작업입니다.

## 테스트 및 남은 확인

테스트는 test/의 Fake Repository 또는 HTTP 어댑터를 주입해 실행합니다.
이는 서버 없이 동작을 검증하는 테스트이며 실서버 성공 검증과 구분합니다.

```bash
flutter test
flutter test test/features/group/presentation/group_layout_test.dart --dart-define=GROUP_SCREENSHOTS=build/group-screens
```

캡처 명령은 프로젝트 루트에서 실행합니다. PNG는 프로젝트 안의
`build/group-screens/`에 저장되며, `build/`는 Git 추적 대상에서 제외됩니다.
OS별 절대 경로나 셸 환경변수 선언 대신 동일한 `--dart-define` 인자를 사용합니다.

#39의 위 기준 커밋에서 정적 분석과 테스트 66개가 통과했고,
393×852·320×568 화면의 레이아웃을 테스트했습니다.
테스트 수는 이후 변경에 따라 달라질 수 있습니다.

실서버 검증에는 서버 주소·인증 연동·테스트 계정이 필요합니다.
실제 생성·가입·상세·목록·관리자 코드 조회 및 구성원 권한을 확인해야 합니다.
오류 코드·이름 길이·서버 중복 방지 정책과 #29 중복 가입 이동 요구사항도 확인해야 합니다.
이 문서는 이러한 미확정 사항을 확정하거나 이슈 #29를 완료 처리하는 근거가 아닙니다.
