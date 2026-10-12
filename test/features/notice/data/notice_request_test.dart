import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/data/models/create_notice_request.dart';
import 'package:moamoa/features/notice/data/models/fetch_notices_request.dart';
import 'package:moamoa/features/notice/data/models/update_notice_request.dart';

void main() {
  test('목록 조회 요청은 meetingId 를 빼고 page, size 만 쿼리로 보낸다', () {
    const request = FetchNoticesRequest(meetingId: 1, page: 0, size: 20);

    expect(request.toJson(), {'page': 0, 'size': 20});
  });

  test('작성 요청은 meetingId 를 빼고 title, content 만 본문으로 보낸다', () {
    const request = CreateNoticeRequest(
      meetingId: 1,
      title: '제목',
      content: '내용',
    );

    expect(request.toJson(), {'title': '제목', 'content': '내용'});
  });

  test('수정 요청은 null 인 필드를 본문에서 뺀다', () {
    const request = UpdateNoticeRequest(
      meetingId: 1,
      noticeId: 30,
      title: '새 제목',
    );

    expect(request.toJson(), {'title': '새 제목'});
  });
}
