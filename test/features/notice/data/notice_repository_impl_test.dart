import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/notice/data/datasources/notice_remote_data_source_impl.dart';
import 'package:moamoa/features/notice/data/repositories/notice_repository_impl.dart';
import 'package:moamoa/features/notice/domain/entities/notice_exception.dart';

/// 서버 대신 정해 둔 응답을 돌려주는 Dio 어댑터
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.statusCode, this.body, this.requests);

  final int statusCode;
  final String body;

  /// 값이 있으면 보낸 요청을 순서대로 담습니다.
  final List<RequestOptions>? requests;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests?.add(options);
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

NoticeRepositoryImpl _repositoryWith(
  int statusCode,
  String body, {
  List<RequestOptions>? requests,
}) {
  final dio = Dio()
    ..httpClientAdapter = _StubAdapter(statusCode, body, requests);
  return NoticeRepositoryImpl(
    noticeRemoteDataSource: NoticeRemoteDataSourceImpl(dio: dio),
  );
}

void main() {
  group(NoticeRepositoryImpl, () {
    test('공통 응답의 data 를 꺼내 공지로 바꾼다', () async {
      final repository = _repositoryWith(200, '''
      {"success": true, "error": null, "timestamp": "2026-10-07T10:00:00+09:00",
       "data": {"noticeId": 30, "title": "10월 회비 안내",
                "content": "10일까지 납부", "createdAt": "2026-10-07T10:00:00+09:00"}}
    ''');

      final notice = await repository.getNoticeDetail(
        meetingId: 1,
        noticeId: 30,
      );

      expect(notice.id, 30);
      expect(notice.content, '10일까지 납부');
    });

    test('응답에 data 가 없으면 크래시 대신 NoticeException 예외가 발생한다', () async {
      final repository = _repositoryWith(
        200,
        '{"success": true, "data": null}',
      );

      await expectLater(
        repository.getNoticeDetail(meetingId: 1, noticeId: 30),
        throwsA(isA<NoticeException>()),
      );
    });

    test('실패 응답이면 서버의 error 메시지와 코드를 담은 NoticeException 예외가 발생한다', () async {
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

    test('읽음 처리는 본문 없이 PUT .../reads/me 로 요청한다', () async {
      final requests = <RequestOptions>[];
      final repository = _repositoryWith(200, '''
      {"success": true, "error": null,
       "data": {"noticeId": 30, "readAt": "2026-10-07T10:05:00+09:00"}}
    ''', requests: requests);

      await repository.markNoticeRead(meetingId: 1, noticeId: 30);

      expect(requests.single.method, 'PUT');
      expect(requests.single.path, '/v1/meetings/1/notices/30/reads/me');
      expect(requests.single.data, isNull);
    });

    test('읽음 처리 실패 응답이면 서버의 코드를 담은 NoticeException 예외가 발생한다', () async {
      final repository = _repositoryWith(404, '''
      {"success": false, "data": null,
       "error": {"code": "NOT_FOUND", "message": "요청한 리소스를 찾을 수 없습니다."}}
    ''');

      await expectLater(
        repository.markNoticeRead(meetingId: 1, noticeId: 30),
        throwsA(
          isA<NoticeException>().having((e) => e.code, 'code', 'NOT_FOUND'),
        ),
      );
    });
  });
}
