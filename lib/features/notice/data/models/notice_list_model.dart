import '../../domain/entities/notice_list_result.dart';
import 'notice_model.dart';

/// 공지 목록 응답 모델 (3-2)
class NoticeListModel {
  const NoticeListModel({
    required this.notices,
    required this.page,
    required this.size,
    required this.hasNext,
  });

  factory NoticeListModel.fromJson(Map<String, dynamic> json) {
    return NoticeListModel(
      notices: (json['notices'] as List<dynamic>)
          .map((item) => NoticeModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      page: json['page'] as int,
      size: json['size'] as int,
      hasNext: json['hasNext'] as bool,
    );
  }

  final List<NoticeModel> notices;
  final int page;
  final int size;
  final bool hasNext;

  NoticeListResult toEntity() => NoticeListResult(
    notices: notices.map((model) => model.toEntity()).toList(),
    page: page,
    size: size,
    hasNext: hasNext,
  );
}
