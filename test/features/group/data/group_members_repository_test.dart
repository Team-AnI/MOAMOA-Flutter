import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/data/datasources/group_remote_data_source_impl.dart';
import 'package:moamoa/features/group/data/repositories/group_repository_impl.dart';
import 'package:moamoa/features/group/domain/entities/group_profile_color.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';

import 'api_group_repository_test.dart' show StubAdapter;

void main() {
  group(GroupRepositoryImpl, () {
    late Dio dio;
    late StubAdapter adapter;
    late GroupRepositoryImpl repository;
    setUp(() {
      adapter = StubAdapter();
      dio = Dio()..httpClientAdapter = adapter;
      repository = GroupRepositoryImpl(
        remoteDataSource: GroupRemoteDataSourceImpl(
          dio: dio,
          baseUrl: 'https://example.test',
          authHeaders: () => {'Authorization': 'Bearer test'},
        ),
      );
    });
    tearDown(() => dio.close());

    Map<String, Object?> member(
      int id, {
      String role = 'MEMBER',
      String? color = 'LIGHT_BLUE',
      String? name = '이모아',
    }) => {
      'memberId': id,
      'userName': name,
      'role': role,
      'profileColor': color,
    };
    void respond(Object? members) {
      adapter.response = {
        'success': true,
        'data': {'members': members},
      };
    }

    test('인증 헤더와 지정한 모임 ID로 구성원 목록을 요청한다', () async {
      respond([]);
      await repository.getMembers(groupId: 7);
      expect(adapter.requests.single.method, 'GET');
      expect(
        adapter.requests.single.path,
        'https://example.test/v1/meetings/7/members',
      );
      expect(adapter.requests.single.headers['Authorization'], 'Bearer test');
    });
    test('memberId를 유지하고 서버의 목록 순서를 바꾸지 않는다', () async {
      respond([member(5), member(3, role: 'ADMIN')]);
      final result = await repository.getMembers(groupId: 1);
      expect(result.map((entry) => entry.memberId), [5, 3]);
      expect(result.last.role, MemberRole.admin);
    });
    for (final entry in {
      'LIGHT_BLUE': GroupProfileColor.lightBlue,
      'GRAY': GroupProfileColor.gray,
      'BLUE': GroupProfileColor.blue,
      'DARK': GroupProfileColor.dark,
    }.entries) {
      test('${entry.key} 프로필 색을 변환한다', () async {
        respond([member(3, color: entry.key)]);
        expect(
          (await repository.getMembers(groupId: 1)).single.profileColor,
          entry.value,
        );
      });
    }
    test('이름이 null이어도 구성원을 누락하지 않는다', () async {
      respond([member(3, name: null)]);
      expect((await repository.getMembers(groupId: 1)).single.userName, isNull);
    });
    test('프로필 색이 아직 없으면 기본 연파랑을 사용한다', () async {
      respond([member(3)..remove('profileColor')]);
      expect(
        (await repository.getMembers(groupId: 1)).single.profileColor,
        GroupProfileColor.lightBlue,
      );
    });
    for (final (label, color) in [('null', null), ('알 수 없는 색', 'RED')]) {
      test('$label 프로필 색이면 기본 연파랑을 사용하고 모든 구성원을 반환한다', () async {
        respond([member(3, color: color), member(5, color: 'DARK')]);
        final result = await repository.getMembers(groupId: 1);
        expect(result.map((entry) => entry.memberId), [3, 5]);
        expect(result.first.profileColor, GroupProfileColor.lightBlue);
        expect(result.last.profileColor, GroupProfileColor.dark);
      });
    }
    test('빈 배열은 빈 구성원 목록을 반환한다', () async {
      respond([]);
      expect(await repository.getMembers(groupId: 1), isEmpty);
    });
    for (final (label, malformed) in <(String, Object?)>[
      ('목록 누락', null),
      ('배열이 아닌 목록', {}),
      ('null 구성원', [null]),
      ('알 수 없는 역할', [member(3, role: 'OWNER')]),
      ('0인 구성원 ID', [member(0)]),
      ('실수 구성원 ID', [member(3)..['memberId'] = 1.5]),
      ('중복 구성원 ID', [member(3), member(3)]),
      ('숫자 이름', [member(3)..['userName'] = 7]),
    ]) {
      test('$label 응답이면 응답 형식 사유의 GroupFailure 예외가 발생한다', () async {
        respond(malformed);
        await expectLater(
          repository.getMembers(groupId: 1),
          throwsA(
            isA<GroupFailure>().having(
              (e) => e.reason,
              'reason',
              GroupFailureReason.invalidResponse,
            ),
          ),
        );
      });
    }
    for (final entry in {
      401: GroupFailureReason.unauthorized,
      403: GroupFailureReason.forbidden,
      404: GroupFailureReason.notFound,
      500: GroupFailureReason.unavailable,
    }.entries) {
      test(
        '구성원 조회 HTTP ${entry.key} 응답이면 지정한 사유의 GroupFailure 예외가 발생한다',
        () async {
          adapter.status = entry.key;
          adapter.response = '';
          await expectLater(
            repository.getMembers(groupId: 1),
            throwsA(
              isA<GroupFailure>().having(
                (e) => e.reason,
                'reason',
                entry.value,
              ),
            ),
          );
        },
      );
    }
  });
}
