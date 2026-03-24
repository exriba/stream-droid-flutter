import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_droid_app/src/generated/common/reward.pb.dart';
import 'package:stream_droid_app/src/providers/reward.dart';
import 'package:stream_droid_app/src/widgets/volume_slider.dart';

class RewardAsset extends ConsumerWidget {
  const RewardAsset({
    super.key,
    required this.rewardId,
    required this.asset,
    required this.handleRemove,
  });
  final Asset asset;
  final String rewardId;
  final Future<void> Function(Asset asset) handleRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.purple[300],
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        spacing: 10,
        children: [
          Icon(
            asset.mediaExtension == Asset_MediaExtension.MP3
                ? Icons.music_note_rounded
                : Icons.play_arrow_rounded,
            color: Colors.white,
          ),
          Expanded(
            child: Text(
              asset.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          VolumeSlider(
            volume: asset.volume.toDouble(),
            handleVolumeChange: (value) async {
              final volume = value.toInt();
              final service = ref.read(rewardServiceProvider);
              await service.updateRewardAsset(rewardId, asset.fileName, volume);
            },
          ),
          IconButton(
            color: Colors.red,
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await handleRemove(asset);
            },
          ),
        ],
      ),
    );
  }
}
