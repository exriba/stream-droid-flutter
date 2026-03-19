import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/providers/hive_storage.dart';
import 'package:stream_droid_app/src/providers/reward.dart';
import 'package:stream_droid_app/src/widgets/reward_asset.dart';
import 'package:stream_droid_app/src/constants/constants.dart' as constants;

class RewardAssetList extends ConsumerStatefulWidget {
  const RewardAssetList({
    super.key,
    required this.rewardId,
    required this.rewardAssets,
  });
  final String rewardId;
  final List<Asset> rewardAssets;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RewardAssetList();
}

class _RewardAssetList extends ConsumerState<RewardAssetList> {
  List<Asset> assets = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      assets = widget.rewardAssets;
    });
  }

  Future<void> _handleAdd() async {
    final service = ref.read(rewardServiceProvider);
    final storage = ref.read(hiveStorageProvider);
    final defaultVolume = storage.get<double>(
      constants.defaultVolumeKey,
      defaultValue: 50,
    );

    final volume = defaultVolume.toInt();
    final rewardAssets = await service.addRewardAssets(widget.rewardId, volume);
    if (rewardAssets.isNotEmpty) {
      setState(() {
        assets = rewardAssets;
      });
    }
  }

  Future<void> _handleRemove(Asset asset) async {
    final service = ref.read(rewardServiceProvider);
    await service.deleteRewardAsset(widget.rewardId, asset.fileName);
    final removed = assets.remove(asset);
    if (removed) {
      setState(() {
        assets = [...assets];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        itemCount: assets.length,
        itemBuilder: (context, index) {
          final asset = assets[index];
          return RewardAsset(
            key: Key(asset.id),
            asset: asset,
            rewardId: widget.rewardId,
            handleRemove: _handleRemove,
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
        onPressed: () async {
          await _handleAdd();
        },
      ),
    );
  }
}
