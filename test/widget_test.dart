import 'package:flutter_test/flutter_test.dart';

import 'package:caffiora/main.dart';

void main() {
  testWidgets('CAFFIORA app starts', (WidgetTester tester) async {
    await tester.pumpWidget(const CaffioraApp());
    expect(find.text('CAFFIORA'), findsOneWidget);
  });
}
