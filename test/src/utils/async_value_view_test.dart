import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/utils/async_value_view.dart';
import 'package:stream_droid_app/src/widgets/error_view.dart';
import 'package:stream_droid_app/src/widgets/loading_spinner.dart';

void main() {
  group('AsyncValueView', () {
    testWidgets('widget loading', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AsyncValueView<String>(
              value: AsyncLoading(),
              builder: _builder,
            ),
          ),
        ),
      );

      expect(find.byType(LoadingSpinner), findsOneWidget);
    });

    testWidgets('widget loads', (tester) async {
      const message = 'I am a Widget';

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AsyncValueView<String>(
              value: AsyncData(message),
              builder: _builder,
            ),
          ),
        ),
      );

      expect(find.text(message), findsOneWidget);
    });

    testWidgets('widget error', (tester) async {
      final error = Exception('Error');

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AsyncValueView<String>(
              value: AsyncError(error, StackTrace.current),
              builder: _builder,
            ),
          ),
        ),
      );

      expect(find.byType(ErrorView), findsOneWidget);
    });
  });
}

Widget _builder(String data) {
  return Text(data);
}
