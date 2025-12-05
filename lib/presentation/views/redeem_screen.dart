import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/presentation/viewmodels/redeem_screen_view_model.dart';
import 'package:stream_droid_app/presentation/widgets/circular_progress.dart';
import 'package:stream_droid_app/presentation/widgets/redeem_card_asset_list.dart';
import 'package:stream_droid_app/presentation/widgets/redeem_card.dart';

class RedeemScreen extends StatelessWidget {
  const RedeemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RedeemScreenViewModel>(
      builder: (context, viewModel, child) {
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
                    child: viewModel.loading
                        ? const CircularProgress()
                        : RedeemCard(
                            redeem: viewModel.redeem!,
                          ),
                  ),
                  const VerticalDivider(
                    indent: 10,
                    endIndent: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: RedeemCardAssetList(
                      redeemId: viewModel.redeemId,
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
      },
    );
  }
}
