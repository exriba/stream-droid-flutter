import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/widgets/feature_switch.dart';

void main() {
  group('FeatureSwitch', () {
    testWidgets('renders switch', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeatureSwitch(
              enabled: true,
              onChanged: (value) async {},
            ),
          ),
        ),
      );

      expect(find.byType(Switch), findsOneWidget);
    });
  });
}
