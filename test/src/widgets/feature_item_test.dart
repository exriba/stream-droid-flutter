import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/widgets/feature_item.dart';

void main() {
  group('FeatureItem', () {
    testWidgets('renders', (tester) async {
      const title = "Dashboard";
      const description = "Description";

      await tester.pumpWidget(
        const MaterialApp(
          home: FeatureItem(
            text: title,
            icon: Icons.dashboard_outlined,
            description: description,
          ),
        ),
      );

      expect(find.byType(Text), findsExactly(2));
      expect(find.byIcon(Icons.dashboard_outlined), findsOneWidget);
    });
  });
}
