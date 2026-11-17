import 'package:dio/dio.dart';
import 'package:moamoa/core/errors/api_error_code.dart';
import 'package:moamoa/core/errors/api_exception.dart';
import 'package:moamoa/core/errors/dio_exception_mapper.dart';

import '../../domain/entities/vote.dart';
import '../../domain/entities/vote_responses.dart';
import '../../domain/repositories/vote_repository.dart';
import '../datasources/vote_remote_data_source.dart';
import '../models/confirm_schedule_request.dart';
import '../models/create_vote_request.dart';
import '../models/fetch_vote_request.dart';
import '../models/fetch_vote_responses_request.dart';
import '../models/submit_my_vote_request.dart';
import '../models/vote_model.dart';
import '../models/vote_responses_model.dart';

/// DataSource 의 응답을 Entity 로 바꾸고, 실패를 공통 [ApiException] 으로 바꿉니다.
///
/// 일시는 UTC ISO-8601 문자열로 보냅니다. 서버는 표기(+09:00, Z)와 관계없이 같은 순간이면 같은 후보로 봅니다.
class VoteRepositoryImpl implements VoteRepository {
  const VoteRepositoryImpl({required VoteRemoteDataSource voteRemoteDataSource})
    : _voteRemoteDataSource = voteRemoteDataSource;

  final VoteRemoteDataSource _voteRemoteDataSource;

  @override
  Future<int> createVote({
    required int meetingId,
    required String title,
    required DateTime voteDeadlineAt,
    required List<DateTime> meetingTimes,
  }) {
    return _guard(
      () => _voteRemoteDataSource.createVote(
        CreateVoteRequest(
          meetingId: meetingId,
          title: title,
          voteDeadlineAt: _isoString(voteDeadlineAt),
          meetingTimes: meetingTimes.map(_isoString).toList(),
        ),
      ),
    );
  }

  @override
  Future<Vote> getVote({required int meetingId, required int scheduleId}) {
    return _guard(() async {
      final response = await _voteRemoteDataSource.fetchVote(
        FetchVoteRequest(meetingId: meetingId, scheduleId: scheduleId),
      );
      return response.toEntity();
    });
  }

  @override
  Future<void> submitMyVote({
    required int meetingId,
    required int scheduleId,
    required List<DateTime> meetingTimes,
  }) {
    return _guard(
      () => _voteRemoteDataSource.submitMyVote(
        SubmitMyVoteRequest(
          meetingId: meetingId,
          scheduleId: scheduleId,
          meetingTimes: meetingTimes.map(_isoString).toList(),
        ),
      ),
    );
  }

  @override
  Future<VoteResponses> getVoteResponses({
    required int meetingId,
    required int scheduleId,
  }) {
    return _guard(() async {
      final response = await _voteRemoteDataSource.fetchVoteResponses(
        FetchVoteResponsesRequest(meetingId: meetingId, scheduleId: scheduleId),
      );
      return response.toEntity();
    });
  }

  @override
  Future<void> confirmSchedule({
    required int meetingId,
    required int scheduleId,
    required DateTime meetingTime,
  }) {
    return _guard(
      () => _voteRemoteDataSource.confirmSchedule(
        ConfirmScheduleRequest(
          meetingId: meetingId,
          scheduleId: scheduleId,
          meetingTime: _isoString(meetingTime),
        ),
      ),
    );
  }

  String _isoString(DateTime dateTime) => dateTime.toUtc().toIso8601String();

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw e.toApiException();
    } on FormatException {
      // 응답은 받았지만 값(일시, 상태)이 예상과 다른 경우
      throw const ApiException(code: ApiErrorCode.unknown);
    } on TypeError {
      // 응답은 받았지만 필드가 없거나 타입이 다른 경우 (fromJson·as 변환 실패)
      throw const ApiException(code: ApiErrorCode.unknown);
    }
  }
}
