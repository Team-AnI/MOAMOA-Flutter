import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/vote_remote_data_source.dart';
import '../../data/datasources/vote_remote_data_source_impl.dart';
import '../../data/repositories/vote_repository_impl.dart';
import '../../domain/repositories/vote_repository.dart';
import '../../domain/usecases/confirm_schedule.dart';
import '../../domain/usecases/create_vote.dart';
import '../../domain/usecases/get_vote.dart';
import '../../domain/usecases/get_vote_responses.dart';
import '../../domain/usecases/submit_my_vote.dart';

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
