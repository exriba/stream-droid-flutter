import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/widgets/reward_asset_list.dart';

void main() {
  group('RewardAssetList', () {
    testWidgets('renders', (tester) async {
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
            body: RewardAssetList(
              rewardId: "rewardId",
              rewardAssets: [asset],
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text(asset.name), findsOneWidget);
      expect(find.byIcon(Icons.music_note_rounded), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });
  });
}
