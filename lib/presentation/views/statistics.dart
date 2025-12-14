import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/core/utils/hex_color.dart';
import 'package:stream_droid_app/presentation/viewmodels/statistics_view_model.dart';
import 'package:stream_droid_app/presentation/widgets/circular_progress.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child:
          Consumer<StatisticsViewModel>(builder: (context, viewModel, child) {
        if (viewModel.state.loading) {
          return const CircularProgress();
        }

        return LayoutBuilder(builder: (context, constraints) {
          final shortestSide = constraints.biggest.shortestSide;
          return PieChart(
            PieChartData(
              sections: viewModel.state.data!
                  .map((rewardRedeem) => PieChartSectionData(
                        color: HexColor.fromHex(rewardRedeem.fill),
                        value: double.parse(rewardRedeem.percentage),
                        badgeWidget: Tooltip(
                          message: rewardRedeem.rewardTitle,
                          child: Text(
                            '${rewardRedeem.percentage}%',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        showTitle: false,
                        radius: shortestSide / 2,
                      ))
                  .toList(),
            ),
          );
        });
      }),
    );
  }
}
