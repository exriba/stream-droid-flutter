import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/layout/navigation_layout.dart';

void main() {
  group('NavigationLayout', () {
    testWidgets('renders', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: NavigationLayout(
              screen: SizedBox.shrink(),
            ),
          ),
        ),
      );

      expect(find.byType(Column), findsOneWidget);
      expect(find.byIcon(Icons.dashboard_outlined), findsOneWidget);
      expect(find.byIcon(Icons.live_tv_outlined), findsOneWidget);
      expect(find.byIcon(Icons.show_chart_outlined), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
      expect(find.byIcon(Icons.logout_outlined), findsOneWidget);
    });
  });
}
