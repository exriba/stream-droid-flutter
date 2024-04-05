import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:stream_droid_app/api/custom_http_client.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/redeem/redeem_view.dart';
import 'package:stream_droid_app/common/hex_color.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardView();
}

class _DashboardView extends State<DashboardView> {
  Redeem? _redeem;

  @override
  void initState() {
    super.initState();
  }

  void _selectRedeem(Redeem? redeem) {
    setState(() {
      _redeem = redeem;
    });
  }

  Future<List<Redeem>> _fetchChannelRedeems() async {
    final httpClient = DependencyManager.getIt.get<ICustomHttpClient>();
    final data = await httpClient.get(urlFragment: UrlFragment.rewards);
    final parsed = (jsonDecode(data) as List).cast<Map<String, dynamic>>();
    return parsed.isEmpty
        ? <Redeem>[]
        : parsed.map<Redeem>((json) => Redeem.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return _redeem == null
        ? Column(
            children: [
              Expanded(
                flex: 1,
                child: FutureBuilder<List<Redeem>>(
                    future: _fetchChannelRedeems(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        Error.throwWithStackTrace(
                            snapshot.error!, snapshot.stackTrace!);
                      }

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
                                    onTap: () {
                                      _selectRedeem(redeem);
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
          )
        : RedeemView(
            redeem: _redeem!,
            handleReturn: _selectRedeem,
          );
  }

  @override
  void dispose() {
    super.dispose();
    _redeem = null;
  }
}
