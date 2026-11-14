import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/settlement_remote_data_source.dart';
import '../../data/repositories/settlement_repository_impl.dart';
import '../../domain/entities/settlement.dart';
import '../../domain/repositories/settlement_repository.dart';

final settlementRemoteDataSourceProvider = Provider<SettlementRemoteDataSource>(
  (ref) => SettlementRemoteDataSource(
    dio: ref.watch(dioProvider),
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
  ),
);

final settlementRepositoryProvider = Provider<SettlementRepository>(
  (ref) => SettlementRepositoryImpl(
    remote: ref.watch(settlementRemoteDataSourceProvider),
  ),
);

/// 목록과 상세는 서버 응답 자체를 구독하므로 독립된 FutureProvider로 둡니다.
final settlementListProvider = FutureProvider.autoDispose
    .family<List<Settlement>, int>(
      (ref, meetingId) =>
          ref.watch(settlementRepositoryProvider).list(meetingId),
    );

final settlementDetailProvider = FutureProvider.autoDispose
    .family<SettlementDetail, (int, int)>(
      (ref, key) =>
          ref.watch(settlementRepositoryProvider).detail(key.$1, key.$2),
    );
