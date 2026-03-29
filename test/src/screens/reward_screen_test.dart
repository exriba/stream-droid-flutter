import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/screens/reward_screen.dart';
import 'package:stream_droid_app/src/widgets/reward_asset.dart';
import 'package:stream_droid_app/src/widgets/reward_asset_list.dart';
import 'package:stream_droid_app/src/widgets/reward_card.dart';

void main() {
  group('RewardScreen', () {
    testWidgets('renders reward card and asset list', (tester) async {
      await mockNetworkImagesFor(() async {
        final reward = Reward(
          id: "rewardId",
          title: "reward",
          prompt: "description",
          streamerId: "id",
          backgroundColor: "#6441A4",
          speech: Speech(enabled: true),
          assets: [
            Asset(
              id: "assetId",
              name: "asset",
              volume: 50,
              fileName: "test.mp4",
              mediaExtension: Asset_MediaExtension.MP4,
            ),
          ],
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RewardScreen(
                reward: reward,
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(RewardCard), findsOneWidget);
        expect(find.byType(RewardAssetList), findsOneWidget);
        expect(find.byType(RewardAsset), findsOneWidget);
      });
    });
  });
}
