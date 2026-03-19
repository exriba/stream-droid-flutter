import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/widgets/reward_asset.dart';

class RewardAssetList extends ConsumerWidget {
  const RewardAssetList({
    super.key,
    required this.rewardId,
    required this.rewardAssets,
  });
  final String rewardId;
  final List<Asset> rewardAssets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        itemCount: rewardAssets.length,
        itemBuilder: (context, index) {
          return RewardAsset(
            key: Key(rewardAssets[index].id),
            asset: rewardAssets[index],
            rewardId: rewardId,
            handleRemove: (fileName) async => {},
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        heroTag: null,
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          // TODO: Implement this
        },
      ),
    );
  }
}
