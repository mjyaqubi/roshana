import 'package:flutter_test/flutter_test.dart';
import 'package:roshana/src/app/app.dart';

void main() {
  testWidgets('Roshana app basic widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const RoshanaApp());
    await tester.pumpAndSettle();

    // Verify Roshana title is rendered
    expect(find.text('روشنا'), findsWidgets);
  });
}
