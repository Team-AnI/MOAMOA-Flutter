import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moamoa/features/group/domain/entities/member_role.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/vote_remote_data_source.dart';
import '../../data/datasources/vote_remote_data_source_impl.dart';
import '../../data/repositories/vote_repository_impl.dart';
import '../../domain/entities/vote.dart';
import '../../domain/entities/vote_responses.dart';
import '../../domain/repositories/vote_repository.dart';
import '../../domain/usecases/confirm_schedule.dart';
import '../../domain/usecases/create_vote.dart';
import '../../domain/usecases/get_vote.dart';
import '../../domain/usecases/get_vote_responses.dart';
import '../../domain/usecases/submit_my_vote.dart';
import '../viewmodels/vote_confirm_state.dart';
import '../viewmodels/vote_confirm_view_model.dart';
import '../viewmodels/vote_create_state.dart';
import '../viewmodels/vote_create_view_model.dart';
import '../viewmodels/vote_submit_state.dart';
import '../viewmodels/vote_submit_view_model.dart';
import '../vote_id.dart';

// DataSource → Repository

final voteRemoteDataSourceProvider = Provider<VoteRemoteDataSource>(
  (ref) => VoteRemoteDataSourceImpl(dio: ref.watch(dioProvider)),
);

final voteRepositoryProvider = Provider<VoteRepository>(
  (ref) => VoteRepositoryImpl(
    voteRemoteDataSource: ref.watch(voteRemoteDataSourceProvider),
  ),
);

// UseCase

final createVoteProvider = Provider<CreateVote>(
  (ref) => CreateVoteImpl(voteRepository: ref.watch(voteRepositoryProvider)),
);

final getVoteProvider = Provider<GetVote>(
  (ref) => GetVoteImpl(voteRepository: ref.watch(voteRepositoryProvider)),
);

final submitMyVoteProvider = Provider<SubmitMyVote>(
  (ref) => SubmitMyVoteImpl(voteRepository: ref.watch(voteRepositoryProvider)),
);

final getVoteResponsesProvider = Provider<GetVoteResponses>(
  (ref) =>
      GetVoteResponsesImpl(voteRepository: ref.watch(voteRepositoryProvider)),
);

final confirmScheduleProvider = Provider<ConfirmSchedule>(
  (ref) =>
      ConfirmScheduleImpl(voteRepository: ref.watch(voteRepositoryProvider)),
);

// ViewModel

/// 인자는 투표를 만들 모임의 id 입니다.
/// autoDispose: 화면을 닫으면 입력값과 이전 제출 결과가 남지 않게 초기화합니다.
final voteCreateProvider = NotifierProvider.autoDispose
    .family<VoteCreateViewModel, VoteCreateState, int>(
      (meetingId) => VoteCreateViewModel(meetingId: meetingId),
    );

// 조회 (응답을 그대로 화면에 보여 주므로 ViewModel 없이 FutureProvider 로 둡니다)

/// 투표와 후보별 가능 인원 (API 5-2). 인자는 볼 투표입니다.
/// autoDispose: 화면을 닫았다가 다시 열면 최신 결과를 다시 받습니다.
final voteProvider = FutureProvider.autoDispose.family<Vote, VoteId>(
  (ref, id) => ref.watch(getVoteProvider)(
    GetVoteParams(meetingId: id.meetingId, scheduleId: id.scheduleId),
  ),
);

/// 구성원별 응답 여부 (API 5-4, 관리자만). 미응답 구성원 이름을 보여줄 때 씁니다.
final voteResponsesProvider = FutureProvider.autoDispose
    .family<VoteResponses, VoteId>(
      (ref, id) => ref.watch(getVoteResponsesProvider)(
        GetVoteResponsesParams(
          meetingId: id.meetingId,
          scheduleId: id.scheduleId,
        ),
      ),
    );

/// 이 모임에서 내가 일정을 확정할 수 있는지(관리자인지) 알려줍니다. 인자는 모임 id 입니다.
/// 역할을 아직 모르거나 불러오지 못했으면 false 로 보고 확정 버튼·응답 명단을 숨깁니다.
/// 최종 권한 확인은 서버가 합니다(5-4·5-5 는 관리자만).
final voteAdminProvider = Provider.autoDispose.family<bool, int>(
  (ref, meetingId) =>
      ref.watch(groupMyRoleProvider(meetingId)).value?.canConfirmSchedules ??
      false,
);

// 동작

/// 인자는 확정할 투표입니다.
/// autoDispose: 화면을 닫으면 이전 요청 결과(성공, 오류)가 남지 않게 초기화합니다.
final voteConfirmProvider = NotifierProvider.autoDispose
    .family<VoteConfirmViewModel, VoteConfirmState, VoteId>(
      (id) => VoteConfirmViewModel(id: id),
    );

/// 인자는 내 응답을 제출할 투표입니다.
/// autoDispose: 화면을 닫으면 이전 요청 결과(성공, 오류)가 남지 않게 초기화합니다.
final voteSubmitProvider = NotifierProvider.autoDispose
    .family<VoteSubmitViewModel, VoteSubmitState, VoteId>(
      (id) => VoteSubmitViewModel(id: id),
    );
