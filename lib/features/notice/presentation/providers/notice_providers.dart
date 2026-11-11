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
import '../../domain/usecases/mark_notice_read.dart';
import '../../domain/usecases/update_notice.dart';
import '../viewmodels/notice_delete_state.dart';
import '../viewmodels/notice_delete_view_model.dart';
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

final markNoticeReadProvider = Provider<MarkNoticeRead>(
  (ref) =>
      MarkNoticeReadImpl(noticeRepository: ref.watch(noticeRepositoryProvider)),
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

/// 공지를 읽음으로 기록합니다. (3-6, family 인자: 공지 상세 인자)
///
/// 상세 화면이 공지를 보여줄 수 있을 때 구독합니다. 화면이 열려 있는 동안에는 한 번만 보내고,
/// 화면을 닫으면 정리되어 다음에 열 때 다시 보냅니다.
/// 실패해도 상세 화면에 영향이 없도록 오류를 무시합니다. 서버는 여러 번 호출해도 처음 읽은 시각을 유지합니다.
final noticeReadProvider = FutureProvider.autoDispose
    .family<void, NoticeDetailArgs>((ref, args) async {
      final markNoticeRead = ref.read(markNoticeReadProvider);
      final params = MarkNoticeReadParams(
        meetingId: args.meetingId,
        noticeId: args.noticeId,
      );
      try {
        await markNoticeRead(params);
      } on Exception {
        // 읽음 기록 실패는 사용자에게 알리지 않습니다. 여기서 잡지 않으면 Provider 가 오류 상태로 남아
        // 자동으로 다시 시도하므로, 공지 예외뿐 아니라 모든 Exception 을 잡습니다.
      }
    });

final noticeDeleteProvider = NotifierProvider.autoDispose
    .family<NoticeDeleteViewModel, NoticeDeleteState, NoticeDetailArgs>(
      (args) => NoticeDeleteViewModel(args: args),
    );

final noticeWriteProvider = AsyncNotifierProvider.autoDispose
    .family<NoticeWriteViewModel, void, int>(
      (meetingId) => NoticeWriteViewModel(meetingId: meetingId),
    );

/// 모임 내 내 역할로 공지 작성 권한을 정합니다. (family 인자: meetingId)
///
/// 역할 조회에 실패하면 일반 구성원처럼 숨기지 않고 다시 시도할 수 있게 합니다.
///
/// AsyncValue 는 재조회 중이거나 실패해도 이전 성공 값을 들고 있으므로, 지금 확인이
/// 끝난 상태(로딩·오류가 아님)일 때만 작성할 수 있습니다.
final noticeWriteAccessProvider = Provider.autoDispose
    .family<NoticeWriteAccess, int>((ref, meetingId) {
      final role = ref.watch(groupMyRoleProvider(meetingId));
      final isSettled = !role.isLoading && !role.hasError;
      return NoticeWriteAccess(
        canWrite: isSettled && (role.value?.canWriteNotices ?? false),
        retryRole: role.hasError
            ? () => ref.invalidate(groupMyRoleProvider(meetingId))
            : null,
      );
    });
