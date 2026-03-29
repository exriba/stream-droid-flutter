import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/widgets/reward_card.dart';

void main() {
  group('RewardCard', () {
    const appIconPath = 'assets/icons/app-icon.png';
    const rewardId = "id";
    final asset = Asset(
      id: "id",
      name: "asset",
      volume: 50,
      fileName: "test.mp3",
      mediaExtension: Asset_MediaExtension.MP3,
    );

    testWidgets('renders with speech enabled', (tester) async {
      await mockNetworkImagesFor(() async {
        final reward = Reward(
          id: rewardId,
          title: "reward",
          prompt: "description",
          streamerId: "id",
          backgroundColor: "#6441A4",
          speech: Speech(enabled: true),
          assets: [asset],
          imageUrl: appIconPath,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RewardCard(
                reward: reward,
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.text(reward.title), findsOneWidget);
        expect(find.text(reward.prompt), findsOneWidget);
        expect(find.byIcon(Icons.record_voice_over), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);

        final widget = find.byType(Switch);
        expect(widget, findsOneWidget);

        final switchWidget = tester.widget<Switch>(widget);
        expect(switchWidget.value, isTrue);
      });
    });

    testWidgets('renders with speech disabled', (tester) async {
      await mockNetworkImagesFor(() async {
        final reward = Reward(
          id: rewardId,
          title: "reward",
          prompt: "description",
          streamerId: "id",
          backgroundColor: "#6441A4",
          speech: Speech(enabled: false),
          assets: [asset],
          imageUrl: appIconPath,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: RewardCard(
                reward: reward,
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.text(reward.title), findsOneWidget);
        expect(find.text(reward.prompt), findsOneWidget);
        expect(find.byIcon(Icons.record_voice_over), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);

        final widget = find.byType(Switch);
        expect(widget, findsOneWidget);

        final switchWidget = tester.widget<Switch>(widget);
        expect(switchWidget.value, isFalse);
      });
    });
  });
}
