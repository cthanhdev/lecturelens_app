import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecturelens_app/main.dart';

void main() {
  testWidgets('LectureLensApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: LectureLensApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(LectureLensApp), findsOneWidget);
  });
}
