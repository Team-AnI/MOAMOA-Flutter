import '../entities/notice_exception.dart';
import '../repositories/notice_repository.dart';
import 'usecase.dart';

/// CreateNotice 전용 파라미터
final class CreateNoticeParams extends Params {
  const CreateNoticeParams({
    required this.meetingId,
    required this.title,
    required this.content,
  });

  final int meetingId;
  final String title;
  final String content;
}

/// 공지 작성 (3-1). 생성된 noticeId 를 반환합니다.
abstract class CreateNotice extends Usecase<int, CreateNoticeParams> {}

final class CreateNoticeImpl implements CreateNotice {
  CreateNoticeImpl({required this._repository});

  final NoticeRepository _repository;

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
    return _repository.createNotice(
      meetingId: params.meetingId,
      title: title,
      content: content,
    );
  }
}
