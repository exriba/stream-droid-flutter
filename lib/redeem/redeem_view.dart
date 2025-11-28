import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_droid_app/api/custom_http_client.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/layout/loading_view.dart';
import 'package:stream_droid_app/redeem/redeem_asset/redeem_asset_list.dart';
import 'package:stream_droid_app/redeem/redeem_card/redeem_card.dart';
import 'package:stream_droid_app/util/dependency_manager.dart';

class RedeemView extends StatelessWidget {
  const RedeemView({super.key, required this.redeemId});
  final String redeemId;

  Future<Redeem> _fetchRedeem() async {
    final httpClient = DependencyManager.getIt.get<ICustomHttpClient>();
    final data =
        await httpClient.get(urlFragment: UrlFragment.reward, id: redeemId);
    final json = jsonDecode(data);
    return Redeem.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: FutureBuilder<Redeem>(
                  future: _fetchRedeem(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      Error.throwWithStackTrace(
                          snapshot.error!, snapshot.stackTrace!);
                    }

                    if (snapshot.hasData) {
                      return RedeemCard(
                        redeem: snapshot.data!,
                      );
                    }

                    return const LoadingView();
                  },
                ),
              ),
              const VerticalDivider(
                indent: 10,
                endIndent: 10,
              ),
              Expanded(
                flex: 5,
                child: RedeemAssetList(
                  redeemId: redeemId,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: FloatingActionButton(
              mini: true,
              heroTag: null,
              onPressed: () {
                context.go(ViewRoute.dashboard.route);
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
