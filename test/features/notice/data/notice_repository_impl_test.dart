import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/data/datasources/notice_remote_data_source_impl.dart';
import 'package:moamoa/features/notice/data/repositories/notice_repository_impl.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';

/// 서버 대신 정해 둔 응답을 돌려주는 Dio 어댑터
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.statusCode, this.body);

  final int statusCode;
  final String body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

NoticeRepositoryImpl _repositoryWith(int statusCode, String body) {
  final dio = Dio()..httpClientAdapter = _StubAdapter(statusCode, body);
  return NoticeRepositoryImpl(
    remoteDataSource: NoticeRemoteDataSourceImpl(dio: dio),
  );
}

void main() {
  test('공통 응답의 data 를 꺼내 공지로 바꾼다', () async {
    final repository = _repositoryWith(200, '''
      {"success": true, "error": null, "timestamp": "2026-10-07T10:00:00+09:00",
       "data": {"noticeId": 30, "title": "10월 회비 안내",
                "content": "10일까지 납부", "createdAt": "2026-10-07T10:00:00+09:00"}}
    ''');

    final notice = await repository.getNoticeDetail(meetingId: 1, noticeId: 30);

    expect(notice.id, 30);
    expect(notice.content, '10일까지 납부');
  });

  test('응답에 data 가 없으면 크래시 대신 NoticeException 을 던진다', () async {
    final repository = _repositoryWith(200, '{"success": true, "data": null}');

    await expectLater(
      repository.getNoticeDetail(meetingId: 1, noticeId: 30),
      throwsA(isA<NoticeException>()),
    );
  });

  test('실패 응답이면 서버의 error 메시지와 코드를 전달한다', () async {
    final repository = _repositoryWith(404, '''
      {"success": false, "data": null,
       "error": {"code": "NOT_FOUND", "message": "요청한 리소스를 찾을 수 없습니다."}}
    ''');

    await expectLater(
      repository.getNoticeDetail(meetingId: 1, noticeId: 30),
      throwsA(
        isA<NoticeException>()
            .having((e) => e.code, 'code', 'NOT_FOUND')
            .having((e) => e.message, 'message', '요청한 리소스를 찾을 수 없습니다.'),
      ),
    );
  });

  test('작성자 · 고정 여부 · 계좌가 오면 함께 변환한다', () async {
    final repository = _repositoryWith(200, '''
      {"success": true, "data": {"noticeId": 30, "title": "회식 정산 안내",
       "content": "아래 계좌로 보내 주세요.", "createdAt": "2026-10-07T10:00:00+09:00",
       "authorNickname": "김도윤", "isPinned": true,
       "account": {"bankName": "카카오뱅크", "accountNumber": "3333-01-1234567",
                   "holderName": "김도윤"}}}
    ''');

    final notice = await repository.getNoticeDetail(meetingId: 1, noticeId: 30);

    expect(notice.authorName, '김도윤');
    expect(notice.isPinned, isTrue);
    expect(notice.account?.accountNumber, '3333-01-1234567');
  });

  test('작성자 · 고정 여부 · 계좌가 없으면 기본값을 쓴다', () async {
    final repository = _repositoryWith(200, '''
      {"success": true, "data": {"noticeId": 30, "title": "10월 회비 안내",
       "createdAt": "2026-10-07T10:00:00+09:00"}}
    ''');

    final notice = await repository.getNoticeDetail(meetingId: 1, noticeId: 30);

    expect(notice.authorName, isNull);
    expect(notice.isPinned, isFalse);
    expect(notice.account, isNull);
  });
}
