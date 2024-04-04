import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:stream_droid_app/api/custom_http_client.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';
import 'package:stream_droid_app/redeem/redeem_view.dart';
import 'package:stream_droid_app/common/hex_color.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  Future<List<Redeem>> _fetchChannelRedeems() async {
    final httpClient = DependencyManager.getIt.get<ICustomHttpClient>();
    final data = await httpClient.get(urlFragment: UrlFragment.rewards);
    final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();
    return parsed.isEmpty
        ? <Redeem>[]
        : parsed.map<Redeem>((json) => Redeem.fromJson(json)).toList();
  }

  Future<void> _selectRedeem(BuildContext context, Redeem redeem) async {
    await Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return RedeemView(redeem: redeem);
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      viewDestination: ViewDestination.dashboard,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: FutureBuilder<List<Redeem>>(
                future: _fetchChannelRedeems(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      padding: const EdgeInsets.all(5),
                      crossAxisCount: responsiveValue(context,
                          xs: 1, sm: 2, md: 3, lg: 4, xl: 5),
                      childAspectRatio: 1.4,
                      // TODO: Convert to custom widget. Add zoom animation.
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
                                  color:
                                      HexColor.fromHex(redeem.backgroundColor),
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
                                onTap: () {
                                  _selectRedeem(context, redeem);
                                },
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }

                  return const Align(
                      child: CircularProgressIndicator(
                    color: Colors.grey,
                  ));
                }),
          ),
        ],
      ),
    );
  }
}
