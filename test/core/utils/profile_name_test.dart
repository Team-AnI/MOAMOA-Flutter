import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/utils/profile_name.dart';

void main() {
  group('profileDisplayName', () {
    test('이름이 있으면 이름을 그대로 돌려준다', () {
      expect(profileDisplayName('김모아'), '김모아');
    });

    test('이름이 null 이면 이름 미설정을 돌려준다', () {
      expect(profileDisplayName(null), '이름 미설정');
    });

    test('이름이 공백뿐이면 이름 미설정을 돌려준다', () {
      expect(profileDisplayName('  '), '이름 미설정');
    });
  });

  group('profileInitial', () {
    test('이름 앞 공백을 빼고 첫 글자를 돌려준다', () {
      expect(profileInitial(' 김모아'), '김');
    });

    test('탈퇴한 사용자도 첫 글자를 돌려준다', () {
      expect(profileInitial('탈퇴한 사용자'), '탈');
    });

    test('이름이 null 이면 물음표를 돌려준다', () {
      expect(profileInitial(null), '?');
    });

    test('이름이 공백뿐이면 물음표를 돌려준다', () {
      expect(profileInitial('  '), '?');
    });
  });
}
