import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stream_droid_app/util/droid_client.dart';
import 'package:stream_droid_app/common/hex_color.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/layout/loading_view.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';

class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatefulWidget> createState() => _StatisticsView();
}

class _StatisticsView extends State<StatisticsView> {
  late Future<List<RedeemRedemption>> _channelRedeemRedemptions;

  @override
  void initState() {
    super.initState();
    _channelRedeemRedemptions = _fetchChannelRedeemRedemptions();
  }

  Future<List<RedeemRedemption>> _fetchChannelRedeemRedemptions() async {
    final httpClient = DependencyManager.getIt.get<IDroidClient>();
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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FutureBuilder<List<RedeemRedemption>>(
          future: _channelRedeemRedemptions,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Error.throwWithStackTrace(snapshot.error!, snapshot.stackTrace!);
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingView();
            }

            if (snapshot.hasData) {
              return LayoutBuilder(builder: (context, constraints) {
                final shortestSide = constraints.biggest.shortestSide;
                return PieChart(
                  PieChartData(
                    sections: snapshot.data!
                        .map((redeemRedemption) => PieChartSectionData(
                              color: HexColor.fromHex(redeemRedemption.color),
                              value: redeemRedemption.number,
                              badgeWidget: Tooltip(
                                message: redeemRedemption.name,
                                child: Text(
                                  '${redeemRedemption.number.toString()}%',
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
            }

            // TODO: No data available widget
            return const SizedBox.shrink();
          }),
    );
  }
}
