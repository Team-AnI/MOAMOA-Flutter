import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/utils/profile_name.dart';

void main() {
  group('profileDisplayName', () {
    test('이름이 있으면 이름을 그대로 돌려준다', () {
      expect('김모아'.profileDisplayName, '김모아');
    });

    test('서버가 보낸 탈퇴한 사용자 이름은 그대로 돌려준다', () {
      expect('탈퇴한 사용자'.profileDisplayName, '탈퇴한 사용자');
    });

    test('이름이 null 이면 이름 미설정을 돌려준다', () {
      const String? userName = null;
      expect(userName.profileDisplayName, '이름 미설정');
    });

    test('이름이 공백뿐이면 이름 미설정을 돌려준다', () {
      expect('  '.profileDisplayName, '이름 미설정');
    });
  });

  group('profileInitial', () {
    test('이름 앞 공백을 빼고 첫 글자를 돌려준다', () {
      expect(' 김모아'.profileInitial, '김');
    });

    test('여러 코드로 된 이모지로 시작하면 이모지 한 글자를 돌려준다', () {
      expect('👨‍👩‍👧 가족'.profileInitial, '👨‍👩‍👧');
    });

    test('서버가 보낸 탈퇴한 사용자 이름은 다른 이름과 같이 첫 글자를 돌려준다', () {
      expect('탈퇴한 사용자'.profileInitial, '탈');
    });

    test('이름이 null 이면 물음표를 돌려준다', () {
      const String? userName = null;
      expect(userName.profileInitial, '?');
    });

    test('이름이 공백뿐이면 물음표를 돌려준다', () {
      expect('  '.profileInitial, '?');
    });
  });
}
