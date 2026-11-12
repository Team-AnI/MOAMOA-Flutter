import 'dart:async';

import 'package:moamoa/features/vote/domain/entities/vote.dart';
import 'package:moamoa/features/vote/domain/entities/vote_responses.dart';
import 'package:moamoa/features/vote/domain/repositories/vote_repository.dart';

/// 테스트용 VoteRepository. 받은 요청을 기록하고, 정해 둔 값을 돌려줍니다.
class FakeVoteRepository implements VoteRepository {
  FakeVoteRepository({this.vote, this.responses, this.createdScheduleId = 21});

  Vote? vote;
  VoteResponses? responses;
  int createdScheduleId;

  /// 지정하면 모든 요청이 이 예외를 던집니다.
  Object? error;

  /// 지정하면 투표 만들기가 이 Completer 가 끝날 때까지 기다립니다. (제출 중 상태 확인용)
  Completer<int>? createCompleter;

  /// 지정하면 일정 확정이 이 Completer 가 끝날 때까지 기다립니다. (확정 중 상태 확인용)
  Completer<void>? confirmCompleter;

  /// 지정하면 일정 확정만 이 예외를 던집니다. (조회는 성공하는 상황)
  Object? confirmError;

  final List<Map<String, Object?>> createCalls = [];
  final List<Map<String, Object?>> submitCalls = [];
  final List<Map<String, Object?>> confirmCalls = [];

  /// 투표 조회를 요청받은 횟수 (다시 불러오는지 확인용)
  int getVoteCallCount = 0;

  @override
  Future<int> createVote({
    required int meetingId,
    required String title,
    required DateTime voteDeadlineAt,
    required List<DateTime> meetingTimes,
  }) async {
    createCalls.add({
      'meetingId': meetingId,
      'title': title,
      'voteDeadlineAt': voteDeadlineAt,
      'meetingTimes': meetingTimes,
    });
    if (error != null) throw error!;
    if (createCompleter case final completer?) return completer.future;
    return createdScheduleId;
  }

  @override
  Future<Vote> getVote({
    required int meetingId,
    required int scheduleId,
  }) async {
    getVoteCallCount++;
    if (error != null) throw error!;
    return vote!;
  }

  @override
  Future<void> submitMyVote({
    required int meetingId,
    required int scheduleId,
    required List<DateTime> meetingTimes,
  }) async {
    submitCalls.add({
      'meetingId': meetingId,
      'scheduleId': scheduleId,
      'meetingTimes': meetingTimes,
    });
    if (error != null) throw error!;
  }

  @override
  Future<VoteResponses> getVoteResponses({
    required int meetingId,
    required int scheduleId,
  }) async {
    if (error != null) throw error!;
    return responses!;
  }

  @override
  Future<void> confirmSchedule({
    required int meetingId,
    required int scheduleId,
    required DateTime meetingTime,
  }) async {
    confirmCalls.add({
      'meetingId': meetingId,
      'scheduleId': scheduleId,
      'meetingTime': meetingTime,
    });
    if ((error ?? confirmError) case final e?) throw e;
    await confirmCompleter?.future;
  }
}
