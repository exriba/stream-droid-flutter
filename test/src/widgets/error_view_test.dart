import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/widgets/error_view.dart';

void main() {
  group('ErrorView', () {
    testWidgets('renders', (tester) async {
      const message = "Something went wrong.";

      await tester.pumpWidget(
        MaterialApp(
          home: ErrorView(
            message: message,
            error: Error(),
            stackTrace: StackTrace.fromString(message),
          ),
        ),
      );

      expect(find.text(message), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
