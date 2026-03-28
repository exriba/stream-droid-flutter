import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/widgets/volume_slider.dart';

void main() {
  group('VolumeSlider', () {
    testWidgets('renders volume up icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VolumeSlider(
              volume: 50,
              handleVolumeChange: (value) async {},
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byIcon(Icons.volume_up_rounded), findsOneWidget);
    });

    testWidgets('renders volume down icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VolumeSlider(
              volume: 49,
              handleVolumeChange: (value) async {},
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byIcon(Icons.volume_down_rounded), findsOneWidget);
    });

    testWidgets('renders volume mute icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VolumeSlider(
              volume: 0,
              handleVolumeChange: (value) async {},
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byIcon(Icons.volume_mute_rounded), findsOneWidget);
    });
  });
}
