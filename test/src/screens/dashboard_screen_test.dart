import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:stream_droid_app/src/generated/common/redeem.pb.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/providers/redeem.dart';
import 'package:stream_droid_app/src/providers/reward.dart';
import 'package:stream_droid_app/src/screens/dashboard_screen.dart';
import 'package:stream_droid_app/src/screens/statistics_screen.dart';

class FakeRewardNotifier extends RewardNotifier {
  @override
  Future<List<Reward>> build() async {
    return <Reward>[
      Reward(
        id: 'rewardId',
        title: 'Test Reward',
        prompt: 'description',
        streamerId: "streamerId",
        imageUrl: "https://example.com/image.jpg",
        backgroundColor: "#6441A4",
        speech: Speech(enabled: false),
        assets: [],
      ),
    ];
  }
}

void main() {
  group('DashboardScreen', () {
    testWidgets('renders grid of rewards', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: ProviderScope(
              overrides: [
                rewardNotificationProvider.overrideWith(
                  () => FakeRewardNotifier(),
                ),
              ],
              child: const DashboardScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final widget = find.byType(GridView);
        expect(widget, findsOneWidget);

        final switchWidget = tester.widget<GridView>(widget);
        expect(switchWidget.childrenDelegate.estimatedChildCount, 1);
      });
    });
  });
}
