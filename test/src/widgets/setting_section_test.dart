import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/widgets/setting_section.dart';

void main() {
  group('SettingSection', () {
    testWidgets('renders text and divider', (tester) async {
      const label = "Media";
      await tester.pumpWidget(
        const MaterialApp(
          home: SettingSection(
            label: label,
          ),
        ),
      );

      expect(find.text(label), findsOneWidget);
      expect(find.byType(Divider), findsOneWidget);
    });
  });
}
