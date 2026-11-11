import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/group_member_profile.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/domain/repositories/group_repository.dart';
import 'package:moamoa/features/group/domain/usecases/get_group_members_impl.dart';
import 'package:moamoa/features/group/domain/usecases/params/get_group_params.dart';
import 'package:moamoa/features/group/presentation/providers/group_members_providers.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_members_state.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_members_view_model.dart';

import '../../fake_group_repository.dart';

const _member = GroupMemberProfile(
  memberId: 3,
  userName: '김모아',
  role: MemberRole.admin,
);

class _Repository extends FakeGroupRepository {
  final calls = <int>[];
  Future<List<GroupMemberProfile>> Function(int)? response;
  @override
  Future<List<GroupMemberProfile>> getMembersByGroupId({
    required int groupId,
  }) async {
    calls.add(groupId);
    return response == null ? [_member] : response!(groupId);
  }
}

void main() {
  group(GetGroupMembersImpl, () {
    test('전달한 모임 ID로 Repository의 구성원 목록을 반환한다', () async {
      final fake = _Repository();
      final members = await GetGroupMembersImpl(groupRepository: fake)(
        const GetGroupParams(groupId: 7),
      );
      expect(members, [_member]);
      expect(fake.calls, [7]);
    });
  });
  group(GroupMembersViewModel, () {
    late _Repository fake;
    late ProviderContainer container;
    setUp(() {
      fake = _Repository();
      container = ProviderContainer.test(
        overrides: [groupRepositoryProvider.overrideWithValue(fake)],
        retry: (_, _) => null,
      );
    });
    Future<GroupMembersState> load([int groupId = 1]) {
      final completed = Completer<GroupMembersState>();
      container.listen(groupMembersProvider(groupId), (_, next) {
        if (!next.isLoading && !completed.isCompleted) completed.complete(next);
      });
      final current = container.read(groupMembersProvider(groupId));
      if (!current.isLoading) completed.complete(current);
      return completed.future;
    }

    test('조회 결과를 기다리기 전에 초기 로딩 상태를 반환한다', () async {
      final gate = Completer<List<GroupMemberProfile>>();
      fake.response = (_) => gate.future;
      final pending = load();
      expect(container.read(groupMembersProvider(1)).isLoading, isTrue);
      expect(container.read(groupMembersProvider(1)).members, isEmpty);
      gate.complete([_member]);
      expect((await pending).isLoading, isFalse);
    });
    test('화면이 폐기된 뒤 도착한 응답은 다시 열린 화면 상태를 바꾸지 않는다', () async {
      final old = Completer<List<GroupMemberProfile>>();
      fake.response = (_) => old.future;
      final subscription = container.listen(groupMembersProvider(1), (_, _) {});
      await Future<void>.delayed(Duration.zero);
      subscription.close();
      await container.pump();
      fake.response = (_) async => [_member.copyWith(userName: '재진입')];
      final reopened = await load();
      old.complete([_member]);
      await Future<void>.delayed(Duration.zero);
      expect(container.read(groupMembersProvider(1)), reopened);
      expect(reopened.members.single.userName, '재진입');
    });
    for (final (label, members) in [
      ('0인 ID', [_member.copyWith(memberId: 0)]),
      ('음수 ID', [_member.copyWith(memberId: -1)]),
      ('중복 ID', [_member, _member]),
    ]) {
      test('$label 구성원 목록은 화면 실패 상태로 처리한다', () async {
        fake.response = (_) async => members;
        final state = await load();
        expect(state.failureReason, GroupFailureReason.invalidResponse);
        expect(state.members, isEmpty);
        expect(state.canRetry, isFalse);
      });
    }
    test('서버 목록과 실제 개수를 표시 상태로 만든다', () async {
      final state = await load();
      expect(state.members, [_member]);
      expect(state.countLabel, '총 1명');
      expect(fake.calls, [1]);
      expect(() => state.members.add(_member), throwsUnsupportedError);
    });
    test('다른 모임의 늦은 응답이 현재 모임의 상태를 덮어쓰지 않는다', () async {
      final first = Completer<List<GroupMemberProfile>>();
      fake.response = (id) async => id == 1
          ? first.future
          : [_member.copyWith(memberId: 7, userName: '다른 모임')];
      final firstRequest = load();
      await Future<void>.delayed(Duration.zero);
      final second = await load(2);
      first.complete([_member]);
      await firstRequest;
      expect(container.read(groupMembersProvider(2)), second);
      expect(second.members.single.memberId, 7);
    });
    test('새로고침 실패 시 이전 구성원 정보를 남기지 않는다', () async {
      await load();
      fake.response = (_) async =>
          throw const GroupFailure(GroupFailureReason.forbidden);
      await container.read(groupMembersProvider(1).notifier).refresh();
      final refreshed = container.read(groupMembersProvider(1));
      expect(refreshed.members, isEmpty);
      expect(refreshed.canRetry, isFalse);
      expect(refreshed.message, '이 모임의 구성원만 목록을 볼 수 있어요.');
    });
    test('재시도하면 이전 실패를 지우고 최신 목록을 보여준다', () async {
      fake.response = (_) async => throw Exception('network');
      final failed = await load();
      expect(failed.canRetry, isTrue);
      fake.response = (_) async => [_member];
      await container.read(groupMembersProvider(1).notifier).refresh();
      final retried = container.read(groupMembersProvider(1));
      expect(retried.hasFailed, isFalse);
      expect(retried.members, [_member]);
    });
    test('재요청보다 늦게 끝난 이전 요청은 새 목록을 덮어쓰지 않는다', () async {
      final old = Completer<List<GroupMemberProfile>>();
      fake.response = (_) => old.future;
      final pending = load();
      await Future<void>.delayed(Duration.zero);
      fake.response = (_) async => [_member.copyWith(userName: '최신')];
      await container.read(groupMembersProvider(1).notifier).refresh();
      final updated = container.read(groupMembersProvider(1));
      old.complete([_member]);
      await pending;
      await Future<void>.delayed(Duration.zero);
      expect(container.read(groupMembersProvider(1)), updated);
      expect(updated.members.single.userName, '최신');
    });
    test('이전 요청의 늦은 실패가 최신 성공 목록을 지우지 않는다', () async {
      final old = Completer<List<GroupMemberProfile>>();
      fake.response = (_) => old.future;
      final pending = load();
      await Future<void>.delayed(Duration.zero);
      fake.response = (_) async => [_member.copyWith(userName: '최신')];
      await container.read(groupMembersProvider(1).notifier).refresh();
      old.completeError(const GroupFailure(GroupFailureReason.forbidden));
      await pending;
      await Future<void>.delayed(Duration.zero);
      final current = container.read(groupMembersProvider(1));
      expect(current.hasFailed, isFalse);
      expect(current.members.single.userName, '최신');
    });
    for (final (label, reason) in [
      ('미인증', GroupFailureReason.unauthorized),
      ('권한 없음', GroupFailureReason.forbidden),
      ('모임 없음', GroupFailureReason.notFound),
      ('응답 형식', GroupFailureReason.invalidResponse),
    ]) {
      test('$label 실패 시 재시도를 숨기고 구성원 목록을 비운다', () async {
        fake.response = (_) async => throw GroupFailure(reason);
        final state = await load();
        expect(state.hasFailed, isTrue);
        expect(state.canRetry, isFalse);
        expect(state.members, isEmpty);
      });
    }
  });
}
