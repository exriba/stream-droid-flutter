import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/utils/types.dart';
import 'package:stream_droid_app/src/widgets/reward_card.dart';
import 'package:stream_droid_app/src/widgets/reward_card_asset_list.dart';

class RewardScreen extends ConsumerWidget {
  const RewardScreen({super.key, required this.reward});
  final Reward reward;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                child: RewardCard(
                  reward: reward,
                ),
              ),
              const VerticalDivider(
                indent: 10,
                endIndent: 10,
                color: Colors.black,
              ),
              Expanded(
                flex: 5,
                child: RewardCardAssetList(
                  rewardId: reward.id,
                  rewardAssets: reward.assets,
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
