import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/notice_exception.dart';
import '../repositories/notice_repository.dart';
import 'usecase.dart';

part 'update_notice.freezed.dart';

/// UpdateNotice 전용 파라미터. null 인 필드는 수정하지 않습니다.
@freezed
abstract class UpdateNoticeParams extends Params with _$UpdateNoticeParams {
  const UpdateNoticeParams._();

  const factory UpdateNoticeParams({
    required int meetingId,
    required int noticeId,
    String? title,
    String? content,
  }) = _UpdateNoticeParams;
}

/// 공지 수정 (3-4)
abstract class UpdateNotice extends Usecase<void, UpdateNoticeParams> {}

final class UpdateNoticeImpl implements UpdateNotice {
  UpdateNoticeImpl({required NoticeRepository noticeRepository})
    : _noticeRepository = noticeRepository;

  final NoticeRepository _noticeRepository;

  /// 보내는 제목과 내용은 공백만 입력할 수 없습니다.
  @override
  Future<void> call(UpdateNoticeParams params) async {
    final title = params.title?.trim();
    final content = params.content?.trim();
    if (title != null && title.isEmpty) {
      throw const NoticeException('공지 제목을 입력해주세요.');
    }
    if (content != null && content.isEmpty) {
      throw const NoticeException('공지 내용을 입력해주세요.');
    }
    return _noticeRepository.updateNotice(
      meetingId: params.meetingId,
      noticeId: params.noticeId,
      title: title,
      content: content,
    );
  }
}
