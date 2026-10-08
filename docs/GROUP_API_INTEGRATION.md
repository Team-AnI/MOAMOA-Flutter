# 모임 API 연동 (#29)

## 구현 범위

P0 초기 계약에 따라 생성, 내 모임 목록, 초대 코드 가입, 모임 상세,
현재 초대 코드 조회를 `GroupRepositoryImpl`에서 구현합니다.
응답은 `success`, `data`, `error`, `timestamp` envelope를 사용합니다.
모임 상세는 목록에서 선택할 때 조회하며, 서버의 `myRole`을 권한 기준으로 사용합니다.
모임 소개는 선택 입력입니다. P0 초대 코드는 만료되지 않으며 가입은 즉시 처리합니다.

## 실행 설정

개발 서버 주소를 확인한 뒤 다음처럼 실행합니다. 실제 주소로 변경해야 합니다.

```bash
flutter run --dart-define=API_BASE_URL=https://your-development-server
```

인증 방식과 로그인 연동은 아직 확정되지 않았습니다.
로그인 담당 기능에서 `groupAuthHeadersProvider`를 override하여 인증 헤더를 공급합니다.
서버 인증 방식이 확정되기 전에 Bearer 방식이나 secure storage 키를 가정하지 않습니다.
인증이 없는 기본값은 null이며 요청 전에 로그인 필요 오류로 처리합니다.
서버 주소가 없으면 네트워크 요청을 보내지 않습니다.

`GroupMember.userId`는 API에서 반환되지 않으므로 nullable입니다.
숫자 `meetingId`는 domain의 문자열 ID로 변환합니다.
목록 응답에는 소개가 없으므로 목록의 소개는 빈 문자열이고 상세에서 보완됩니다.

## 오류와 요청 중복

가입의 `NOT_FOUND`는 유효하지 않은 코드, `CONFLICT`는 이미 참여 중인 모임으로
처리합니다. 재가입 오류에서는 기존 모임 목록으로 이동하여 선택할 수 있습니다.
오류 응답에 meetingId가 없고 초대 코드 미리보기는 후순위라 재가입 모임을 자동 선택하지 않습니다.
`UNAUTHORIZED`, `FORBIDDEN`, 입력 오류, 네트워크/응답 형식 오류도 별도로 처리합니다.

생성·가입 처리 중 버튼 비활성화와 ViewModel 재진입 방지를 적용합니다.
서버의 멱등성 키/중복 생성 처리 계약은 아직 명세에 없으므로 추가 헤더나 자동 재시도를
임의로 구현하지 않습니다. 서버 중복 방지는 백엔드 확인이 필요합니다.

## 디자인과 남은 검증

Figma Moa4 기준으로 Pretendard, 원본 SVG 아이콘, 색상·간격·둥근 카드·하단 버튼을 적용했습니다.
빈 화면, 역할별 목록, 모임 추가 시트, 2단계 생성, 생성 완료, 코드 입력·조회·복사를 구현했습니다.
사진 업로드, 승인제, QR/링크 가입, 코드 만료/재발급/폐기는 이번 P0 계약 밖이며
시안의 해당 부분은 구현하지 않았습니다. 가입은 즉시 처리하며 기본 이미지는 모임명의 첫 글자를 사용합니다.
모임 홈은 이름·소개·역할·초대 코드 진입만 표시하는 기본 화면입니다.
홈의 일정·공지·회비, 알림·계정 탭, 목록의 할 일·다음 일정·편집 메뉴는 담당 기능과 별도 연결이 필요합니다.
393×852 및 320×568에서 입력 보존·화면 넘침을 검사했습니다.
화면 캡처는 테스트에서 Fake Repository를 주입한 결과이며 실서버 검증 자료는 아닙니다.
서버 주소, 인증 연동, 테스트 계정이 제공되면 실제 생성·가입·권한을 검증해야 합니다.
해당 검증 전에는 기능 PR을 Draft로 유지하고 이슈 #29를 완료로 처리하지 않습니다.

## 화면 캡처 재생성

```bash
flutter test test/features/group/presentation/group_layout_test.dart --dart-define=GROUP_SCREENSHOTS=/private/tmp/moamoa-group-screens
```

Figma 파일: `dipwukM8kkC96pfOaqHvd3`, 빈 화면 `103:5368`, 프로필 `103:5400`, 소개 `103:5515`,
생성 완료 `103:5562`, 가입 `44:12586`, 코드 조회 `44:12536`, 목록 `103:5613`, 추가 시트 `103:5807`.
폰트 라이선스는 `assets/fonts/Pretendard-LICENSE.txt`에 포함했습니다.

## PR 순서

1. `feature/#29-group-entities` → `develop`: 공유 엔티티와 권한 테스트, 관련 이슈는 `Ref #29`.
2. 선행 PR 머지 후 기능 브랜치에 `upstream/develop`을 merge합니다.
3. `feature/#29-group-create-join` → `develop`: 기능 구현 Draft PR.

선행 PR 머지 전 기능 PR도 develop을 대상으로 만들 수 있지만 엔티티 변경이 함께
표시됩니다. 기능 PR 본문에 선행 PR 링크를 적고, 선행 PR 머지 후 동기화합니다.

## 생성 화면의 계정 및 미지원 옵션

로그인 기능에서 `groupCurrentUserNameProvider`를 override하여 실제 계정의 표시 이름을 공급합니다.
미연결 상태에는 `관리자 · 계정 정보 미연결`을 표시하며 임의의 이름을 쓰지 않습니다.
앨범 선택과 승인 후 가입은 API 계약이 없어 비활성 상태로 표시합니다.
모임 이름은 Figma의 20자 카운터와 입력 제한을 적용했습니다.
