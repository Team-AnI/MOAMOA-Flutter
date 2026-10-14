import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notice_list_result.dart';
import 'notice_model.dart';

part 'notice_list_model.freezed.dart';
part 'notice_list_model.g.dart';

/// 공지 목록 응답 모델 (3-2)
@freezed
abstract class NoticeListModel with _$NoticeListModel {
  const factory NoticeListModel({
    required List<NoticeModel> notices,
    required int page,
    required int size,
    required bool hasNext,
  }) = _NoticeListModel;

  factory NoticeListModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeListModelFromJson(json);
}

/// 응답 모델을 도메인 Entity 로 바꿉니다.
///
/// 생성 코드와 분리해 두어, 변환 로직을 고칠 때 build_runner 를 다시 돌리지 않아도 됩니다.
extension NoticeListModelX on NoticeListModel {
  NoticeListResult toEntity() => NoticeListResult(
    notices: notices.map((model) => model.toEntity()).toList(),
    page: page,
    size: size,
    hasNext: hasNext,
  );
}
