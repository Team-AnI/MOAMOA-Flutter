import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/features/vote/data/datasources/vote_remote_data_source_impl.dart';
import 'package:moamoa/features/vote/data/repositories/vote_repository_impl.dart';
import 'package:moamoa/features/vote/domain/entities/vote_status.dart';

/// 서버 대신 정해 둔 응답을 돌려주고, 받은 요청을 기록하는 Dio 어댑터
class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.statusCode, this.body);

  final int statusCode;
  final String body;
  RequestOptions? request;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    request = options;
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

void main() {
  late _StubAdapter adapter;
  late VoteRepositoryImpl repository;

  void respond(int statusCode, String body) {
    adapter = _StubAdapter(statusCode, body);
    final dio = Dio()..httpClientAdapter = adapter;
    repository = VoteRepositoryImpl(
      voteRemoteDataSource: VoteRemoteDataSourceImpl(dio: dio),
    );
  }

  const voteBody = '''
    {"success": true, "error": null, "timestamp": "2026-10-20T10:00:00+09:00",
     "data": {"scheduleId": 21, "title": "10월 정기 모임", "status": "VOTING",
              "voteDeadlineAt": "2026-10-22T23:59:00+09:00", "votingOpen": true,
              "memberCount": 8, "respondedCount": 5, "myResponded": true,
              "candidates": [
                {"meetingTime": "2026-10-24T19:00:00+09:00", "availableCount": 3, "selectedByMe": true},
                {"meetingTime": "2026-10-25T14:00:00+09:00", "availableCount": 5, "selectedByMe": false}
              ]}}
  ''';

  group(VoteRepositoryImpl, () {
    test('투표 조회 응답을 후보 목록이 있는 투표로 바꾼다', () async {
      respond(200, voteBody);

      final vote = await repository.getVote(meetingId: 1, scheduleId: 21);

      expect(adapter.request!.method, 'GET');
      expect(adapter.request!.path, '/v1/meetings/1/schedules/21/candidates');
      expect(vote.status, VoteStatus.voting);
      expect(vote.votingOpen, isTrue);
      expect(vote.respondedCount, 5);
      expect(vote.candidates, hasLength(2));
      expect(
        vote.candidates.first.meetingTime.isAtSameMomentAs(
          DateTime.utc(2026, 10, 24, 10),
        ),
        isTrue,
      );
      expect(vote.candidates.first.selectedByMe, isTrue);
    });

    test('투표를 만들면 시각을 UTC ISO 문자열로 보내고 일정 id 를 돌려준다', () async {
      respond(201, '''
        {"success": true, "error": null,
         "data": {"scheduleId": 21, "title": "10월 정기 모임",
                  "voteDeadlineAt": "2026-10-22T23:59:00+09:00",
                  "meetingTimes": ["2026-10-24T19:00:00+09:00"]}}
      ''');

      final scheduleId = await repository.createVote(
        meetingId: 1,
        title: '10월 정기 모임',
        voteDeadlineAt: DateTime.utc(2026, 10, 22, 14, 59),
        meetingTimes: [DateTime.utc(2026, 10, 24, 10)],
      );

      expect(scheduleId, 21);
      expect(adapter.request!.method, 'POST');
      expect(adapter.request!.path, '/v1/meetings/1/schedule-votes');
      expect(adapter.request!.data, {
        'title': '10월 정기 모임',
        'voteDeadlineAt': '2026-10-22T14:59:00.000Z',
        'meetingTimes': ['2026-10-24T10:00:00.000Z'],
      });
    });

    test('가능한 시간이 없으면 빈 목록을 PUT 으로 제출한다', () async {
      respond(200, '''
        {"success": true, "error": null,
         "data": {"scheduleId": 21, "meetingTimes": [],
                  "submittedAt": "2026-10-20T10:00:00+09:00"}}
      ''');

      await repository.submitMyVote(
        meetingId: 1,
        scheduleId: 21,
        meetingTimes: [],
      );

      expect(adapter.request!.method, 'PUT');
      expect(adapter.request!.path, '/v1/meetings/1/schedules/21/votes/me');
      expect(adapter.request!.data, {'meetingTimes': <String>[]});
    });

    test('참여 현황의 이름은 userName 이 없으면 nickname 을 쓰고 둘 다 없으면 null 이다', () async {
      respond(200, '''
        {"success": true, "error": null,
         "data": {"memberCount": 3, "respondedCount": 1, "members": [
           {"memberId": 3, "userName": "김모아", "responded": true,
            "submittedAt": "2026-10-20T09:30:00+09:00"},
           {"memberId": 5, "nickname": "이모아", "responded": false, "submittedAt": null},
           {"memberId": 7, "responded": false, "submittedAt": null}
         ]}}
      ''');

      final responses = await repository.getVoteResponses(
        meetingId: 1,
        scheduleId: 21,
      );

      expect(
        adapter.request!.path,
        '/v1/meetings/1/schedules/21/vote-responses',
      );
      expect(responses.respondedCount, 1);
      expect(responses.members.map((m) => m.userName), ['김모아', '이모아', null]);
      expect(responses.members.first.submittedAt, isNotNull);
      expect(responses.members.last.submittedAt, isNull);
    });

    test('일정을 확정하면 고른 후보 시간을 POST 로 보낸다', () async {
      respond(200, '''
        {"success": true, "error": null,
         "data": {"scheduleId": 21, "title": "10월 정기 모임",
                  "startAt": "2026-10-25T14:00:00+09:00", "status": "CONFIRMED"}}
      ''');

      await repository.confirmSchedule(
        meetingId: 1,
        scheduleId: 21,
        meetingTime: DateTime.utc(2026, 10, 25, 5),
      );

      expect(adapter.request!.method, 'POST');
      expect(adapter.request!.path, '/v1/meetings/1/schedules/21/confirmation');
      expect(adapter.request!.data, {
        'meetingTime': '2026-10-25T05:00:00.000Z',
      });
    });

    test('마감된 투표에 제출하면 서버의 오류 코드와 메시지를 ApiException 으로 전달한다', () async {
      respond(422, '''
        {"success": false, "data": null,
         "error": {"code": "UNPROCESSABLE_ENTITY", "message": "투표가 마감되었습니다."}}
      ''');

      await expectLater(
        repository.submitMyVote(meetingId: 1, scheduleId: 21, meetingTimes: []),
        throwsA(
          isA<ApiException>()
              .having((e) => e.code, 'code', ApiErrorCode.unprocessableEntity)
              .having((e) => e.message, 'message', '투표가 마감되었습니다.'),
        ),
      );
    });

    test('응답에 data 가 없으면 unknown 코드의 ApiException 을 던진다', () async {
      respond(200, '{"success": true, "data": null}');

      await expectLater(
        repository.getVote(meetingId: 1, scheduleId: 21),
        throwsA(
          isA<ApiException>().having(
            (e) => e.code,
            'code',
            ApiErrorCode.unknown,
          ),
        ),
      );
    });

    test('data 에 기대한 값이 없으면 unknown 코드의 ApiException 을 던진다', () async {
      respond(200, '{"success": true, "data": {}}');

      await expectLater(
        repository.createVote(
          meetingId: 1,
          title: '10월 정기 모임',
          voteDeadlineAt: DateTime.utc(2099, 10, 12),
          meetingTimes: [DateTime.utc(2099, 10, 13, 9)],
        ),
        throwsA(
          isA<ApiException>().having(
            (e) => e.code,
            'code',
            ApiErrorCode.unknown,
          ),
        ),
      );
    });

    test('알 수 없는 투표 상태가 오면 unknown 코드의 ApiException 을 던진다', () async {
      respond(200, voteBody.replaceFirst('"VOTING"', '"PAUSED"'));

      await expectLater(
        repository.getVote(meetingId: 1, scheduleId: 21),
        throwsA(
          isA<ApiException>().having(
            (e) => e.code,
            'code',
            ApiErrorCode.unknown,
          ),
        ),
      );
    });
  });
}
