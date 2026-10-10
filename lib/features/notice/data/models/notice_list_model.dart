import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notice_list_result.dart';
import 'notice_model.dart';

part 'notice_list_model.freezed.dart';
part 'notice_list_model.g.dart';

/// 공지 목록 응답 모델 (3-2)
@freezed
abstract class NoticeListModel with _$NoticeListModel {
  const NoticeListModel._();

  const factory NoticeListModel({
    required List<NoticeModel> notices,
    required int page,
    required int size,
    required bool hasNext,
  }) = _NoticeListModel;

  factory NoticeListModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeListModelFromJson(json);

  NoticeListResult toEntity() => NoticeListResult(
    notices: notices.map((model) => model.toEntity()).toList(),
    page: page,
    size: size,
    hasNext: hasNext,
  );
}
