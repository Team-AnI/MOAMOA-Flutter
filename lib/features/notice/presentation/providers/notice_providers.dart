import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/notice_remote_data_source.dart';
import '../../data/datasources/notice_remote_data_source_impl.dart';
import '../../data/repositories/notice_repository_impl.dart';
import '../../domain/entities/member_role.dart';
import '../../domain/entities/notice.dart';
import '../../domain/repositories/notice_repository.dart';
import '../../domain/usecases/create_notice.dart';
import '../../domain/usecases/delete_notice.dart';
import '../../domain/usecases/get_my_role.dart';
import '../../domain/usecases/get_notice_detail.dart';
import '../../domain/usecases/get_notices.dart';
import '../../domain/usecases/update_notice.dart';
import '../viewmodels/notice_detail_view_model.dart';
import '../viewmodels/notice_list_state.dart';
import '../viewmodels/notice_list_view_model.dart';
import '../viewmodels/notice_write_view_model.dart';

// DataSource → Repository

final noticeRemoteDataSourceProvider = Provider<NoticeRemoteDataSource>(
  (ref) => NoticeRemoteDataSourceImpl(dio: ref.watch(dioProvider)),
);

final noticeRepositoryProvider = Provider<NoticeRepository>(
  (ref) => NoticeRepositoryImpl(
    remoteDataSource: ref.watch(noticeRemoteDataSourceProvider),
  ),
);

// UseCase

final getNoticesProvider = Provider<GetNotices>(
  (ref) => GetNoticesImpl(repository: ref.watch(noticeRepositoryProvider)),
);

final getNoticeDetailProvider = Provider<GetNoticeDetail>(
  (ref) => GetNoticeDetailImpl(repository: ref.watch(noticeRepositoryProvider)),
);

final createNoticeProvider = Provider<CreateNotice>(
  (ref) => CreateNoticeImpl(repository: ref.watch(noticeRepositoryProvider)),
);

final updateNoticeProvider = Provider<UpdateNotice>(
  (ref) => UpdateNoticeImpl(repository: ref.watch(noticeRepositoryProvider)),
);

final deleteNoticeProvider = Provider<DeleteNotice>(
  (ref) => DeleteNoticeImpl(repository: ref.watch(noticeRepositoryProvider)),
);

final getMyRoleProvider = Provider<GetMyRole>(
  (ref) => GetMyRoleImpl(repository: ref.watch(noticeRepositoryProvider)),
);

// ViewModel / 화면 상태 (family 인자: meetingId)

/// 모임에서 내 역할. 작성·수정·삭제 버튼 노출에 사용합니다.
final noticeMyRoleProvider = FutureProvider.autoDispose.family<MemberRole, int>(
  (ref, meetingId) =>
      ref.watch(getMyRoleProvider)(GetMyRoleParams(meetingId: meetingId)),
);

final noticeListProvider = AsyncNotifierProvider.autoDispose
    .family<NoticeListViewModel, NoticeListState, int>(NoticeListViewModel.new);

final noticeDetailProvider = AsyncNotifierProvider.autoDispose
    .family<NoticeDetailViewModel, Notice, NoticeDetailArgs>(
      NoticeDetailViewModel.new,
    );

final noticeWriteProvider = AsyncNotifierProvider.autoDispose
    .family<NoticeWriteViewModel, void, int>(NoticeWriteViewModel.new);
