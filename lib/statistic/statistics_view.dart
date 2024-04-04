import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stream_droid_app/api/custom_http_client.dart';
import 'package:stream_droid_app/common/hex_color.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  Future<List<RedeemRedemption>> _fetchChannelRedeemRedemptions() async {
    final httpClient = DependencyManager.getIt.get<ICustomHttpClient>();
    final data = await httpClient.get(urlFragment: UrlFragment.redemptions);
    final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();
    return parsed.isEmpty
        ? <RedeemRedemption>[]
        : parsed
            .map<RedeemRedemption>((json) => RedeemRedemption.fromJson(json))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      viewDestination: ViewDestination.statistics,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<List<RedeemRedemption>>(
            future: _fetchChannelRedeemRedemptions(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return LayoutBuilder(builder: (context, constraints) {
                  final shortestSide = constraints.biggest.shortestSide;
                  return PieChart(
                    PieChartData(
                      sections: snapshot.data!
                          .map((x) => PieChartSectionData(
                                color: HexColor.fromHex(x.color),
                                value: x.number,
                                badgeWidget: Tooltip(
                                  message: x.name,
                                  child: Text(
                                    '${x.number.toString()}%',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                showTitle: false,
                                radius: shortestSide / 2,
                              ))
                          .toList(),
                    ),
                  );
                });
              }
              return const Align(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }),
      ),
    );
  }
}
