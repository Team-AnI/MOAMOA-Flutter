import 'package:flutter_test/flutter_test.dart';
import 'package:moamoa/core/constants/profile_color.dart';

void main() {
  group(ProfileColor, () {
    for (final entry in {
      'LIGHT_BLUE': ProfileColor.lightBlue,
      'GRAY': ProfileColor.gray,
      'BLUE': ProfileColor.blue,
      'DARK': ProfileColor.dark,
    }.entries) {
      test('서버 값 ${entry.key} 는 ${entry.value.name} 색이 된다', () {
        expect(ProfileColor.fromServer(entry.key), entry.value);
      });
    }

    test('서버 값이 없으면 기본 연파랑으로 바꾼다', () {
      expect(ProfileColor.fromServer(null), ProfileColor.lightBlue);
    });

    test('모르는 서버 값이면 기본 연파랑으로 바꾼다', () {
      expect(ProfileColor.fromServer('RED'), ProfileColor.lightBlue);
    });
  });
}
