import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/redeem/redeem_asset/redeem_asset_list.dart';
import 'package:stream_droid_app/redeem/redeem_card/redeem_card.dart';

class RedeemView extends StatelessWidget {
  const RedeemView(
      {super.key, required this.redeem, required this.handleReturn});
  final Redeem redeem;
  final void Function(Redeem? redeem) handleReturn;

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
                child: RedeemCard(
                  redeem: redeem,
                ),
              ),
              const VerticalDivider(
                indent: 10,
                endIndent: 10,
              ),
              Expanded(
                flex: 5,
                child: Consumer<UserContext>(
                    builder: (context, userContext, child) {
                  return RedeemAssetList(
                    userContext: userContext,
                    redeemId: redeem.id,
                  );
                }),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                handleReturn(null);
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
