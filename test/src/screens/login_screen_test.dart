import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/screens/login_screen.dart';
import 'package:stream_droid_app/src/widgets/login_button.dart';

void main() {
  group('LoginScreen', () {
    testWidgets('renders feature widgets and login button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProviderScope(
            child: LoginScreen(),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(LoginButton), findsOneWidget);
      expect(find.byIcon(Icons.dashboard_outlined), findsOneWidget);
      expect(find.byIcon(Icons.live_tv_outlined), findsOneWidget);
      expect(find.byIcon(Icons.show_chart_outlined), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    });
  });
}
