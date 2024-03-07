import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stream_droid_app/layout/base_view.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';
import 'package:stream_droid_app/utils/view_destination.dart';

class StatisticsView extends StatelessWidget with BaseView {
  const StatisticsView({super.key});

  @override
  ViewDestination get view => ViewDestination.statistics;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      baseView: this,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final shortestSide = constraints.biggest.shortestSide;
            return PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: Colors.red,
                    value: 50,
                    radius: shortestSide / 2,
                  ),
                  PieChartSectionData(
                    color: Colors.green,
                    value: 30,
                    radius: shortestSide / 2,
                  ),
                  PieChartSectionData(
                    color: Colors.purple,
                    value: 20,
                    radius: shortestSide / 2,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
