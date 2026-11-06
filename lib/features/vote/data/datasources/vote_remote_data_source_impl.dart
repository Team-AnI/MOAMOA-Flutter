import 'package:dio/dio.dart';

import '../models/confirm_schedule_request.dart';
import '../models/create_vote_request.dart';
import '../models/fetch_vote_request.dart';
import '../models/fetch_vote_responses_request.dart';
import '../models/submit_my_vote_request.dart';
import '../models/vote_model.dart';
import '../models/vote_responses_model.dart';
import 'vote_remote_data_source.dart';

/// 투표 API 를 Dio 로 호출합니다.
///
/// 실패 응답은 Dio 가 던지는 DioException 을 그대로 Repository 로 전달합니다.
class VoteRemoteDataSourceImpl implements VoteRemoteDataSource {
  const VoteRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<int> createVote(CreateVoteRequest request) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}/schedule-votes',
      data: request.toJson(),
    );
    return _data(response)['scheduleId'] as int;
  }

  @override
  Future<VoteModel> fetchVote(FetchVoteRequest request) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}/schedules/${request.scheduleId}/candidates',
    );
    return VoteModel.fromJson(_data(response));
  }

  @override
  Future<void> submitMyVote(SubmitMyVoteRequest request) async {
    await _dio.put<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}/schedules/${request.scheduleId}/votes/me',
      data: request.toJson(),
    );
  }

  @override
  Future<VoteResponsesModel> fetchVoteResponses(
    FetchVoteResponsesRequest request,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}/schedules/${request.scheduleId}/vote-responses',
    );
    return VoteResponsesModel.fromJson(_data(response));
  }

  @override
  Future<void> confirmSchedule(ConfirmScheduleRequest request) async {
    await _dio.post<Map<String, dynamic>>(
      '/v1/meetings/${request.meetingId}/schedules/${request.scheduleId}/confirmation',
      data: request.toJson(),
    );
  }

  /// 공통 응답 { success, data, error, timestamp } 에서 data 를 꺼냅니다.
  ///
  /// 응답 형식이 다르면 크래시 대신 DioException 을 던져 Repository 에서 처리되게 합니다.
  Map<String, dynamic> _data(Response<Map<String, dynamic>> response) {
    final data = response.data?['data'];
    if (data is! Map<String, dynamic>) {
      throw DioException.badResponse(
        statusCode: response.statusCode ?? 200,
        requestOptions: response.requestOptions,
        response: response,
      );
    }
    return data;
  }
}
