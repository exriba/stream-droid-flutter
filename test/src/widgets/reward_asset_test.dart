import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/widgets/reward_asset.dart';

void main() {
  group('RewardAsset', () {
    const rewardId = "id";
    testWidgets('renders reward audio asset', (tester) async {
      final asset = Asset(
        id: "id",
        name: "asset",
        volume: 50,
        fileName: "test.mp3",
        mediaExtension: Asset_MediaExtension.MP3,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RewardAsset(
              rewardId: rewardId,
              asset: asset,
              handleRemove: (_) async {},
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text(asset.name), findsOneWidget);
      expect(find.byIcon(Icons.music_note_rounded), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });

    testWidgets('renders reward video asset', (tester) async {
      final asset = Asset(
        id: "id",
        name: "asset",
        volume: 50,
        fileName: "test.mp4",
        mediaExtension: Asset_MediaExtension.MP4,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RewardAsset(
              rewardId: rewardId,
              asset: asset,
              handleRemove: (_) async {},
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text(asset.name), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow_rounded), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });
  });
}
