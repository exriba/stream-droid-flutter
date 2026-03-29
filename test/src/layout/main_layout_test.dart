import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/layout/main_layout.dart';
import 'package:stream_droid_app/src/providers/global_error.dart';

void main() {
  group('MainLayout', () {
    testWidgets('renders layout', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MainLayout(
            screen: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('renders snackbar when error is set', (tester) async {
      const testError = 'Something went wrong';

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            globalErrorProvider.overrideWith((ref) => testError),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: MainLayout(
                screen: SizedBox.shrink(),
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text(testError), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
