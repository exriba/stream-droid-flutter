import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/widgets/loading_spinner.dart';

void main() {
  group('LoadingSpinner', () {
    testWidgets('renders', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: LoadingSpinner(),
        ),
      );

      expect(find.byType(LoadingSpinner), findsOneWidget);
    });
  });
}
