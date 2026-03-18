import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_droid_app/src/providers/reward.dart';
import 'package:stream_droid_app/src/utils/types.dart';
import 'package:stream_droid_app/src/widgets/reward_card.dart';
import 'package:stream_droid_app/src/widgets/loading_spinner.dart';
import 'package:stream_droid_app/src/widgets/reward_card_asset_list.dart';

class RewardScreen extends ConsumerWidget {
  const RewardScreen({super.key, required this.rewardId});
  final String rewardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewardState = ref.watch(rewardProvider(rewardId));

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 4, 4, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: rewardState.when(
                  data: (rewardResponse) => RewardCard(
                    reward: rewardResponse.reward,
                  ),
                  error: (_, __) => const SizedBox.shrink(),
                  loading: () => const LoadingSpinner(),
                ),
              ),
              const VerticalDivider(
                indent: 10,
                endIndent: 10,
                color: Colors.black,
              ),
              Expanded(
                flex: 5,
                child: rewardState.when(
                  data: (rewardResponse) => RewardCardAssetList(
                    rewardId: rewardResponse.reward.id,
                    rewardAssets: rewardResponse.reward.assets,
                  ),
                  error: (_, __) => const SizedBox.shrink(),
                  loading: () => const LoadingSpinner(),
                ),
              ),
            ],
          ),
          FloatingActionButton(
            mini: true,
            heroTag: null,
            backgroundColor: Colors.deepPurple,
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              context.go(ViewRoute.dashboard.route);
            },
          ),
        ],
      ),
    );
  }
}
