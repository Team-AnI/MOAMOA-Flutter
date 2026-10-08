import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/data/repositories/api_group_repository.dart';
import 'package:moamoa/features/group/domain/entities/group_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';

class StubAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];
  Object response = {
    'success': true,
    'data': {'meetingId': 1, 'name': '러닝', 'myRole': 'ADMIN'},
  };
  int status = 200;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      jsonEncode(response),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late Dio dio;
  late StubAdapter adapter;
  late ApiGroupRepository repository;
  setUp(() {
    adapter = StubAdapter();
    dio = Dio()..httpClientAdapter = adapter;
    repository = ApiGroupRepository(
      dio,
      baseUrl: 'https://example.test',
      authHeaders: () => {'Authorization': 'test-auth'},
    );
  });
  tearDown(() => dio.close());

  test('생성은 선택 소개를 생략하고 ADMIN 응답을 사용한다', () async {
    final current = await repository.createGroup(name: '러닝', description: '');
    expect(adapter.requests.single.path, 'https://example.test/v1/meetings');
    expect(adapter.requests.single.method, 'POST');
    expect(adapter.requests.single.data, {'name': '러닝'});
    expect(adapter.requests.single.headers['Authorization'], 'test-auth');
    expect(current.group.id, '1');
    expect(current.membership.userId, isNull);
    expect(current.membership.role, GroupRole.admin);
  });

  test('목록은 data.meetings를 파싱하고 빈 목록도 허용한다', () async {
    adapter.response = {
      'success': true,
      'data': {'meetings': []},
    };
    expect(await repository.getMyGroups(), isEmpty);
    adapter.response = {
      'success': true,
      'data': {
        'meetings': [
          {'meetingId': 1, 'name': '러닝', 'memberCount': 12, 'myRole': 'MEMBER'},
        ],
      },
    };
    expect(
      (await repository.getMyGroups()).single.membership.role,
      GroupRole.member,
    );
  });

  test('가입은 inviteCode를 보내고 MEMBER 응답을 사용한다', () async {
    adapter.response = {
      'success': true,
      'data': {'meetingId': 1, 'name': '러닝', 'myRole': 'MEMBER'},
    };
    expect(
      (await repository.joinGroup(inviteCode: 'ABC')).canViewInviteCode,
      isFalse,
    );
    expect(adapter.requests.single.path, 'https://example.test/v1/me/meetings');
    expect(adapter.requests.single.data, {'inviteCode': 'ABC'});
  });

  test('상세 조회는 소개와 역할을 읽는다', () async {
    adapter.response = {
      'success': true,
      'data': {
        'meetingId': 1,
        'name': '러닝',
        'description': '주말',
        'myRole': 'ADMIN',
      },
    };
    expect((await repository.getGroup('1')).group.description, '주말');
    expect(adapter.requests.single.path, 'https://example.test/v1/meetings/1');
  });

  test('초대 코드는 data.inviteCode를 읽는다', () async {
    adapter.response = {
      'success': true,
      'data': {'inviteCode': 'ABC'},
    };
    expect(await repository.getInviteCode(groupId: '1'), 'ABC');
    expect(
      adapter.requests.single.path,
      'https://example.test/v1/meetings/1/invite-code',
    );
  });

  for (final entry in {
    'NOT_FOUND': GroupFailureReason.invalidCode,
    'CONFLICT': GroupFailureReason.alreadyJoined,
    'UNAUTHORIZED': GroupFailureReason.unauthorized,
    'FORBIDDEN': GroupFailureReason.forbidden,
    'VALIDATION_ERROR': GroupFailureReason.validation,
  }.entries) {
    test('가입 오류 ${entry.key}를 도메인 오류로 변환한다', () async {
      adapter.status = entry.key == 'CONFLICT'
          ? 409
          : entry.key == 'NOT_FOUND'
          ? 404
          : 400;
      adapter.response = {
        'success': false,
        'data': null,
        'error': {'code': entry.key, 'message': '오류'},
      };
      await expectLater(
        repository.joinGroup(inviteCode: 'ABC'),
        throwsA(
          isA<GroupFailure>().having(
            (error) => error.reason,
            'reason',
            entry.value,
          ),
        ),
      );
    });
  }

  test('알 수 없는 역할은 관리자 권한으로 해석하지 않는다', () async {
    adapter.response = {
      'success': true,
      'data': {'meetingId': 1, 'name': '러닝', 'myRole': 'OWNER'},
    };
    await expectLater(repository.getGroup('1'), throwsA(isA<GroupFailure>()));
  });

  test('잘못된 envelope는 오류 처리한다', () async {
    adapter.response = {
      'data': {'inviteCode': 'ABC'},
    };
    await expectLater(
      repository.getInviteCode(groupId: '1'),
      throwsA(isA<GroupFailure>()),
    );
  });

  test('서버와 인증 설정이 없으면 네트워크 요청을 보내지 않는다', () async {
    final missingServer = ApiGroupRepository(
      dio,
      baseUrl: '',
      authHeaders: () => {},
    );
    await expectLater(
      missingServer.getMyGroups(),
      throwsA(isA<GroupFailure>()),
    );
    final missingAuth = ApiGroupRepository(
      dio,
      baseUrl: 'https://example.test',
      authHeaders: () => null,
    );
    await expectLater(
      missingAuth.getMyGroups(),
      throwsA(
        isA<GroupFailure>().having(
          (error) => error.reason,
          'reason',
          GroupFailureReason.unauthorized,
        ),
      ),
    );
    expect(adapter.requests, isEmpty);
  });
}
