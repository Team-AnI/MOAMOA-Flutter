import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/features/group/domain/entities/group_failure_reason.dart';
import 'package:moamoa/features/group/presentation/viewmodels/group_state.dart';

void main() {
  group(GroupState, () {
    for (final reason in GroupFailureReason.values) {
      test('${reason.name}의 재시도 여부는 오류 문구와 무관하게 결정된다', () {
        final state = GroupState(
          failureReason: reason,
          errorMessage: '바뀐 오류 문구',
        );
        expect(state.canRetryFailure, reason == GroupFailureReason.unavailable);
      });
    }
    test('분류되지 않은 예외는 재시도할 수 있다', () {
      expect(const GroupState(errorMessage: '예외').canRetryFailure, isTrue);
    });
    for (final reason in [null, GroupFailureReason.unavailable]) {
      test('$reason 저장 실패는 ViewModel 문구가 바뀌어도 입력 보존 안내를 표시한다', () {
        expect(
          GroupState(
            failureReason: reason,
            errorMessage: '바뀐 문구',
          ).editFailureMessage,
          '입력한 내용은 그대로 두었어요. 다시 시도해 주세요',
        );
      });
      test('$reason 삭제 실패는 ViewModel 문구가 바뀌어도 일시적 실패 안내를 표시한다', () {
        expect(
          GroupState(
            failureReason: reason,
            errorMessage: '바뀐 문구',
          ).deleteFailureMessage,
          '잠시 후 다시 시도해 주세요. 모임은 그대로 남아 있어요.',
        );
      });
    }
    test('권한 실패는 해당 원인 문구를 유지한다', () {
      const state = GroupState(
        failureReason: GroupFailureReason.forbidden,
        errorMessage: '관리자 권한이 필요합니다.',
      );
      expect(state.editFailureMessage, '관리자 권한이 필요합니다.');
      expect(state.deleteFailureMessage, '관리자 권한이 필요합니다.');
    });
  });
}
