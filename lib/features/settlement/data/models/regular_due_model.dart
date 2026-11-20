import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/settlement.dart';

part 'regular_due_model.freezed.dart';
part 'regular_due_model.g.dart';

@freezed
abstract class RegularDueModel with _$RegularDueModel {
  const factory RegularDueModel({
    required int regularDuesId,
    required String title,
    required int amount,
    required String cycleType,
    required String cycleDay,
    required String sendTime,
    required int dueDays,
    required String bankName,
    required String accountNumber,
    required String accountHolder,
    required bool isActive,
    required bool postNotice,
  }) = _RegularDueModel;
  factory RegularDueModel.fromJson(Map<String, dynamic> json) =>
      _$RegularDueModelFromJson(json);
}

extension RegularDueModelX on RegularDueModel {
  RegularDue toEntity() => RegularDue(
    id: regularDuesId,
    title: title,
    amount: amount,
    cycle: DuesCycle.fromServer(cycleType),
    cycleDay: cycleDay,
    sendTime: sendTime,
    dueDays: dueDays,
    bankName: bankName,
    accountNumber: accountNumber,
    accountHolder: accountHolder,
    isActive: isActive,
    postNotice: postNotice,
  );
}
