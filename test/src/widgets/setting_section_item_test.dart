import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/widgets/setting_section_item.dart';

void main() {
  group('SettingSectionItem', () {
    testWidgets('renders text and item', (tester) async {
      const label = "setting";
      await tester.pumpWidget(
        const MaterialApp(
          home: SettingSectionItem(
            label: label,
            item: SizedBox.shrink(),
          ),
        ),
      );

      expect(find.text(label), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
    });
  });
}
