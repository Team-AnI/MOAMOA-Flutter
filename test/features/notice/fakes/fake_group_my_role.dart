import 'dart:async';

import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';

/// 모임 내 역할을 정해 둔 값으로 돌려주는 테스트용 대체물
class FakeGroupMyRole {
  FakeGroupMyRole({this.role = MemberRole.member});

  FakeGroupMyRole.admin() : role = MemberRole.admin;

  /// 정상 응답으로 돌려줄 역할
  MemberRole role;

  /// 값이 있으면 역할 조회가 이 오류로 실패합니다. (역할 조회만 실패하는 상황)
  Object? error;

  /// 값이 있으면 역할 조회 응답이 이 Completer 가 끝날 때까지 늦어집니다. (재조회 중인 상황)
  Completer<void>? gate;

  /// 역할 조회를 요청받은 모임 ID (요청 순서대로)
  final requestedGroupIds = <int>[];

  Override get override =>
      groupMyRoleProvider.overrideWith((ref, groupId) async {
        requestedGroupIds.add(groupId);
        await gate?.future;
        if (error != null) throw error!;
        return role;
      });
}
