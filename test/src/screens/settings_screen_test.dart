import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stream_droid_app/src/providers/hive_storage.dart';
import 'package:stream_droid_app/src/screens/settings_screen.dart';
import 'package:stream_droid_app/src/services/hive_storage.dart';
import 'package:stream_droid_app/src/widgets/setting_section.dart';
import 'package:stream_droid_app/src/widgets/setting_section_item.dart';
import 'package:stream_droid_app/src/widgets/volume_slider.dart';

class MockHiveStorage extends Mock implements HiveStorage {}

void main() {
  group('SettingsScreen', () {
    late MockHiveStorage mockHiveStorage;

    setUp(() {
      mockHiveStorage = MockHiveStorage();
    });

    testWidgets('renders settings sections', (tester) async {
      when(
        () => mockHiveStorage.get<double>(
          any(),
          defaultValue: any(named: 'defaultValue'),
        ),
      ).thenAnswer((_) => 50);

      await tester.pumpWidget(
        MaterialApp(
          home: ProviderScope(
            overrides: [
              hiveStorageProvider.overrideWithValue(mockHiveStorage),
            ],
            child: const Scaffold(
              body: SettingsScreen(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(SettingSection), findsOneWidget);
      expect(find.byType(SettingSectionItem), findsOneWidget);
      expect(find.byType(VolumeSlider), findsOneWidget);
    });
  });
}
