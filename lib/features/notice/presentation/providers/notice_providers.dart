import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../group/domain/entities/member_role.dart';
import '../../../group/presentation/providers/group_providers.dart';
import '../../data/datasources/notice_remote_data_source.dart';
import '../../data/datasources/notice_remote_data_source_impl.dart';
import '../../data/repositories/notice_repository_impl.dart';
import '../../domain/entities/notice.dart';
import '../../domain/repositories/notice_repository.dart';
import '../../domain/usecases/create_notice.dart';
import '../../domain/usecases/delete_notice.dart';
import '../../domain/usecases/get_notice_detail.dart';
import '../../domain/usecases/get_notices.dart';
import '../../domain/usecases/update_notice.dart';
import '../viewmodels/notice_detail_view_model.dart';
import '../viewmodels/notice_list_state.dart';
import '../viewmodels/notice_list_view_model.dart';
import '../viewmodels/notice_write_access.dart';
import '../viewmodels/notice_write_view_model.dart';

// DataSource → Repository

final noticeRemoteDataSourceProvider = Provider<NoticeRemoteDataSource>(
  (ref) => NoticeRemoteDataSourceImpl(dio: ref.watch(dioProvider)),
);

final noticeRepositoryProvider = Provider<NoticeRepository>(
  (ref) => NoticeRepositoryImpl(
    noticeRemoteDataSource: ref.watch(noticeRemoteDataSourceProvider),
  ),
);

// UseCase

final getNoticesProvider = Provider<GetNotices>(
  (ref) =>
      GetNoticesImpl(noticeRepository: ref.watch(noticeRepositoryProvider)),
);

final getNoticeDetailProvider = Provider<GetNoticeDetail>(
  (ref) => GetNoticeDetailImpl(
    noticeRepository: ref.watch(noticeRepositoryProvider),
  ),
);

final createNoticeProvider = Provider<CreateNotice>(
  (ref) =>
      CreateNoticeImpl(noticeRepository: ref.watch(noticeRepositoryProvider)),
);

final updateNoticeProvider = Provider<UpdateNotice>(
  (ref) =>
      UpdateNoticeImpl(noticeRepository: ref.watch(noticeRepositoryProvider)),
);

final deleteNoticeProvider = Provider<DeleteNotice>(
  (ref) =>
      DeleteNoticeImpl(noticeRepository: ref.watch(noticeRepositoryProvider)),
);

// ViewModel / 화면 상태 (family 인자: meetingId)

final noticeListProvider = AsyncNotifierProvider.autoDispose
    .family<NoticeListViewModel, NoticeListState, int>(
      (meetingId) => NoticeListViewModel(meetingId: meetingId),
    );

final noticeDetailProvider = AsyncNotifierProvider.autoDispose
    .family<NoticeDetailViewModel, Notice, NoticeDetailArgs>(
      (args) => NoticeDetailViewModel(args: args),
    );

final noticeWriteProvider = AsyncNotifierProvider.autoDispose
    .family<NoticeWriteViewModel, void, int>(
      (meetingId) => NoticeWriteViewModel(meetingId: meetingId),
    );

/// 모임 내 내 역할로 공지 작성 권한을 정합니다. (family 인자: meetingId)
///
/// 역할 조회에 실패하면 일반 구성원처럼 숨기지 않고 다시 시도할 수 있게 합니다.
final noticeWriteAccessProvider = Provider.autoDispose
    .family<NoticeWriteAccess, int>((ref, meetingId) {
      final role = ref.watch(groupMyRoleProvider(meetingId));
      return NoticeWriteAccess(
        canWrite: role.value?.canWriteNotices ?? false,
        retryRole: role.hasError
            ? () => ref.invalidate(groupMyRoleProvider(meetingId))
            : null,
      );
    });
