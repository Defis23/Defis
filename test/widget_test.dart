import 'package:flutter_test/flutter_test.dart';
import 'package:robspace_mobile/app.dart';

void main() {
  testWidgets('ROBSPACE app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Login'), findsOneWidget);
  });
}