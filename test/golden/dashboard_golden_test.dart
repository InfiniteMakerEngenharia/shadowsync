import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:shadowsync/src/app.dart';

Future<void> _pumpWithSize(
  WidgetTester tester, {
  required Size size,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  await tester.pumpWidget(const ShadowSyncApp());
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Dashboard phone portrait golden', (tester) async {
    await _pumpWithSize(tester, size: const Size(390, 844));

    await expectLater(
      find.byType(ShadowSyncApp),
      matchesGoldenFile('goldens/dashboard_phone_portrait.png'),
    );
  });

  testWidgets('Dashboard phone landscape golden', (tester) async {
    await _pumpWithSize(tester, size: const Size(844, 390));

    await expectLater(
      find.byType(ShadowSyncApp),
      matchesGoldenFile('goldens/dashboard_phone_landscape.png'),
    );
  });
}
