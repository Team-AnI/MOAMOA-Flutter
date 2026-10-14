import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/notice_exception.dart';
import '../repositories/notice_repository.dart';
import 'usecase.dart';

part 'create_notice.freezed.dart';

/// CreateNotice 전용 파라미터
@freezed
abstract class CreateNoticeParams extends Params with _$CreateNoticeParams {
  const CreateNoticeParams._();

  const factory CreateNoticeParams({
    required int meetingId,
    required String title,
    required String content,
  }) = _CreateNoticeParams;
}

/// 공지 작성 (3-1). 생성된 noticeId 를 반환합니다.
abstract class CreateNotice extends Usecase<int, CreateNoticeParams> {}

final class CreateNoticeImpl implements CreateNotice {
  CreateNoticeImpl({required NoticeRepository noticeRepository})
    : _noticeRepository = noticeRepository;

  final NoticeRepository _noticeRepository;

  /// 제목과 내용은 필수이며, 공백만 입력할 수 없습니다.
  @override
  Future<int> call(CreateNoticeParams params) async {
    final title = params.title.trim();
    final content = params.content.trim();
    if (title.isEmpty) {
      throw const NoticeException('공지 제목을 입력해주세요.');
    }
    if (content.isEmpty) {
      throw const NoticeException('공지 내용을 입력해주세요.');
    }
    return _noticeRepository.createNotice(
      meetingId: params.meetingId,
      title: title,
      content: content,
    );
  }
}
