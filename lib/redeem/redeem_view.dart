import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/common/types.dart';
import 'package:stream_droid_app/context/user_context.dart';
import 'package:stream_droid_app/layout/navigation_view.dart';
import 'package:stream_droid_app/redeem/redeem_asset/redeem_asset_list.dart';
import 'package:stream_droid_app/redeem/redeem_card/redeem_card.dart';

class RedeemView extends StatelessWidget {
  const RedeemView({super.key, required this.redeem});
  final actionButtonColor = const Color.fromRGBO(33, 33, 33, 1);
  final Redeem redeem;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
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
              child:
                  Consumer<UserContext>(builder: (context, userContext, child) {
                return RedeemAssetList(
                  userContext: userContext,
                  redeemId: redeem.id,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
