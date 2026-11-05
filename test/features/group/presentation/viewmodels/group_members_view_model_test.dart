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
  Future<List<GroupMemberProfile>> getMembers({required int groupId}) async {
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
    Future<GroupMembersState> load() {
      container.listen(groupMembersProvider(1), (_, _) {});
      return container.read(groupMembersProvider(1).future);
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
      container.listen(groupMembersProvider(2), (_, _) {});
      final second = await container.read(groupMembersProvider(2).future);
      first.complete([_member]);
      await firstRequest;
      expect(container.read(groupMembersProvider(2)).requireValue, second);
      expect(second.members.single.memberId, 7);
    });
    test('새로고침 실패 시 이전 구성원 정보를 남기지 않는다', () async {
      await load();
      fake.response = (_) async =>
          throw const GroupFailure(GroupFailureReason.forbidden);
      final refreshed = await container.refresh(groupMembersProvider(1).future);
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
      final retried = container.read(groupMembersProvider(1)).requireValue;
      expect(retried.hasFailed, isFalse);
      expect(retried.members, [_member]);
    });
    test('재요청보다 늦게 끝난 이전 요청은 새 목록을 덮어쓰지 않는다', () async {
      final old = Completer<List<GroupMemberProfile>>();
      fake.response = (_) => old.future;
      final pending = load();
      await Future<void>.delayed(Duration.zero);
      fake.response = (_) async => [_member.copyWith(userName: '최신')];
      final updated = await container.refresh(groupMembersProvider(1).future);
      old.complete([_member]);
      await pending;
      await Future<void>.delayed(Duration.zero);
      expect(container.read(groupMembersProvider(1)).requireValue, updated);
      expect(updated.members.single.userName, '최신');
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
