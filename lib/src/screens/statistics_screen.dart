import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/generated/service/redeemservice.pb.dart';
import 'package:stream_droid_app/src/providers/redeem.dart';
import 'package:stream_droid_app/src/utils/hex_color.dart';
import 'package:stream_droid_app/src/utils/async_value_view.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewardRedeemState = ref.watch(redeemNotificationProvider);

    return AsyncValueView<RewardRedeemResponse>(
      value: rewardRedeemState,
      builder: (response) => Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final shortestSide = constraints.biggest.shortestSide;
            return PieChart(
              PieChartData(
                sections: response.rewardRedeems
                    .map(
                      (rewardRedeem) => PieChartSectionData(
                        color: HexColor.fromHex(rewardRedeem.fill),
                        value: double.parse(rewardRedeem.percentage),
                        badgeWidget: Tooltip(
                          message: rewardRedeem.rewardTitle,
                          child: Text(
                            '${rewardRedeem.percentage}%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        showTitle: false,
                        radius: shortestSide / 2,
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
