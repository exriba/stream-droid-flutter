import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';
import 'package:stream_droid_app/model/reward.dart';
import 'package:stream_droid_app/redeem/redeem_view.dart';
import 'package:stream_droid_app/utils/hex_color.dart';
import 'package:stream_droid_app/utils/view_destination.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  Future<List<Reward>> fetchChannelRedeems() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final data =
        await rootBundle.loadString("assets/mock-channel-redeems.json");
    final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();
    return parsed.isEmpty
        ? <Reward>[]
        : parsed.map<Reward>((json) => Reward.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reward>>(
      future: fetchChannelRedeems(),
      builder: (context, AsyncSnapshot<List<Reward>> snapshot) {
        return NavigationView(
          viewDestination: ViewDestination.dashboard,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: snapshot.hasData
                    ? GridView.count(
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        padding: const EdgeInsets.all(5),
                        crossAxisCount: responsiveValue(context,
                            xs: 1, sm: 2, md: 3, lg: 4, xl: 5),
                        childAspectRatio: 1.4,
                        // TO-DO: Convert to custom widget. Add zoom animation.
                        children: snapshot.data!
                            .map(
                              (redeem) => Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  mouseCursor: SystemMouseCursors.click,
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Card(
                                    key: Key(redeem.id),
                                    elevation: 5,
                                    color: HexColor.fromHex(
                                        redeem.backgroundColor),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.network(redeem.imageUrl),
                                        Text(
                                          redeem.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    await Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return const RedeemView();
                                          },
                                          transitionDuration: Duration.zero,
                                          reverseTransitionDuration:
                                              Duration.zero,
                                        ));
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      )
                    : const Align(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
