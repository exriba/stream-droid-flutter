import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stream_droid_app/core/utils/types.dart';
import 'package:stream_droid_app/presentation/viewmodels/reward_screen_view_model.dart';
import 'package:stream_droid_app/presentation/widgets/circular_progress.dart';
import 'package:stream_droid_app/presentation/widgets/reward_card_asset_list.dart';
import 'package:stream_droid_app/presentation/widgets/reward_card.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RewardScreenViewModel>(
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
                    child: viewModel.state.loading
                        ? const CircularProgress()
                        : RewardCard(
                            reward: viewModel.state.data!,
                          ),
                  ),
                  const VerticalDivider(
                    indent: 10,
                    endIndent: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: RewardCardAssetList(
                      rewardId: viewModel.rewardId,
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
