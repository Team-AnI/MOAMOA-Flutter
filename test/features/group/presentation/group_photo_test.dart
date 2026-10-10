import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moamoa/app/app.dart';
import 'package:moamoa/features/group/presentation/providers/group_providers.dart';

class TestPicker extends ImagePicker {
  final sources = <ImageSource>[];
  bool cancel = false;
  bool deny = false;
  @override
  Future<XFile?> pickImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    bool requestFullMetadata = true,
  }) async {
    sources.add(source);
    if (deny) throw PlatformException(code: 'photo_access_denied');
    if (cancel) return null;
    return XFile.fromData(
      base64Decode(
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQIHWP4z8DwHwAFgAI/ScLbtAAAAABJRU5ErkJggg==',
      ),
      name: 'photo.png',
      mimeType: 'image/png',
    );
  }
}

void main() {
  testWidgets('앨범·촬영 미리보기, 취소 시 보존, 권한 오류와 기본 이미지 복원', (tester) async {
    final picker = TestPicker();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          groupUseMockProvider.overrideWithValue(true),
          groupImagePickerProvider.overrideWithValue(picker),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('내 모임'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('모임 만들기'));
    await tester.pumpAndSettle();
    Future<void> action(String label) async {
      await tester.tap(find.byTooltip('모임 사진 선택'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(label));
      await tester.pumpAndSettle();
    }

    await action('앨범에서 선택');
    expect(picker.sources.last, ImageSource.gallery);
    expect(find.byType(Image), findsOneWidget);
    picker.cancel = true;
    await action('사진 찍기');
    expect(picker.sources.last, ImageSource.camera);
    expect(find.byType(Image), findsOneWidget);
    picker.cancel = false;
    await action('사진 찍기');
    expect(find.byType(Image), findsOneWidget);
    picker.deny = true;
    await action('앨범에서 선택');
    expect(find.text('사진 또는 카메라 권한을 설정에서 허용해주세요.'), findsOneWidget);
    await action('기본 이미지로 바꾸기');
    expect(find.byType(Image), findsNothing);
  });
  testWidgets('Mock 생성 사진이 목록과 홈에 유지되고 사진 없는 모임에는 적용되지 않는다', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          groupUseMockProvider.overrideWithValue(true),
          groupImagePickerProvider.overrideWithValue(TestPicker()),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('내 모임'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('모임 만들기'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), '사진 모임');
    await tester.tap(find.byTooltip('모임 사진 선택'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('앨범에서 선택'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '모임 만들기'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('내 모임으로'));
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsOneWidget);
    await tester.tap(find.text('사진 모임'));
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsOneWidget);
    await tester.tap(find.byTooltip('내 모임 목록'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('모임 추가'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('초대 코드로 가입'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'MOA-JOIN');
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('가입하기'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('내 모임으로'));
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsOneWidget);
    await tester.tap(find.text('초대받은 스터디'));
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
