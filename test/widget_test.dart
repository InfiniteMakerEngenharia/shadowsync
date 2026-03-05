import 'package:flutter_test/flutter_test.dart';

import 'package:shadowsync/src/app.dart';

void main() {
  testWidgets('Renderiza dashboard principal', (WidgetTester tester) async {
    await tester.pumpWidget(const ShadowSyncApp());
    await tester.pumpAndSettle();

    expect(find.text('Minhas Rotinas'), findsOneWidget);
    expect(find.text('Serviço em segundo plano: Ativo. Próximo: 19:59'), findsOneWidget);
    expect(find.text('Novo Backup'), findsOneWidget);
  });
}
