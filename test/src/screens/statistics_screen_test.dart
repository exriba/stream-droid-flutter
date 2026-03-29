import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_droid_app/src/generated/common/redeem.pb.dart';
import 'package:stream_droid_app/src/providers/redeem.dart';
import 'package:stream_droid_app/src/screens/statistics_screen.dart';

class FakeRedeemNotifier extends RedeemNotifier {
  @override
  Future<List<RewardRedeem>> build() async {
    return <RewardRedeem>[
      RewardRedeem(
        rewardId: 'rewardId',
        rewardTitle: 'Test Reward',
        fill: "#6441A4",
        percentage: "100",
      ),
    ];
  }
}

void main() {
  group('StatisticsScreen', () {
    testWidgets('renders pie chart', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ProviderScope(
            overrides: [
              redeemNotificationProvider.overrideWith(
                () => FakeRedeemNotifier(),
              ),
            ],
            child: const StatisticsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(PieChart), findsOneWidget);
    });
  });
}
